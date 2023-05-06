Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F056F9359
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEFRay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:30:52 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928E1608D
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 10:30:50 -0700 (PDT)
Date:   Sat, 06 May 2023 17:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1683394248; x=1683653448;
        bh=gyUQwzJC1ZRfkAbs3rA4h6kPX2f1RCrCAewsnOz8ABw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CUb+05hP0RRZ1U7ZloZJaSpHCkNFytkAUbHIbZUP1nHXp8BKizDxDTHgdLn3KjBU8
         b/L0YZXxv70fwnCEANY298F7DrBmjeJV8jh8okHcmzlF2b9dx0NSuwy2RbZIVXvtxp
         bsPzLcI4V4QRrUgDSPHjQJcoSYYDdgWl6Q0EdGjE=
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] misc: fastrpc: use coherent pool for untranslated Compute Banks
Message-ID: <b5b3f7b4-3b08-d5cf-b1b9-795e9491166f@connolly.tech>
In-Reply-To: <20230327184204.498032-3-me@dylanvanassche.be>
References: <20230327184204.498032-1-me@dylanvanassche.be> <20230327184204.498032-3-me@dylanvanassche.be>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/03/2023 19:42, Dylan Van Assche wrote:
> Use fastrpc_remote_heap_alloc to allocate from the FastRPC device
> instead of the Compute Bank when the session ID is 0. This ensures
> that the allocation is inside the coherent DMA pool which is already
> accessible to the DSP. This is necessary to support FastRPC devices
> which do not have dedicated Compute Banks such as the SLPI on the SDM845.
> The latter uses an allocated CMA region instead of FastRPC Compute Banks.
>
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index caf2ae556956..b7ddf6b90022 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -939,7 +939,10 @@ static int fastrpc_get_args(u32 kernel, struct fastr=
pc_invoke_ctx *ctx)
>
>  =09ctx->msg_sz =3D pkt_size;
>
> -=09err =3D fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
> +=09if (ctx->fl->sctx->sid)
> +=09=09err =3D fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
> +=09else
> +=09=09err =3D fastrpc_remote_heap_alloc(ctx->fl, dev, pkt_size, &ctx->bu=
f);
>  =09if (err)
>  =09=09return err;
>
> --
> 2.39.2
>

--
Kind Regards,
Caleb

