Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17B610E88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJ1KeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJ1Kd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:33:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA361C20A9;
        Fri, 28 Oct 2022 03:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F554B80189;
        Fri, 28 Oct 2022 10:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD3C433D6;
        Fri, 28 Oct 2022 10:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666953234;
        bh=yYY52+M13hWrqJU6NL54oJi3GSh9XgqjKNnE4Zx4jos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQsBmQv9M44f7b8F5Wn0DVVo0y1nv78b7L6ibXBRArg0KzfUUEufrVwX8dy1nJcvL
         7CJIMFMkqq5Gac+2i9S6oSkTzeKdbkfbKqwTeWeknsPV9V/DGGJWvWl9QpSst3i0PT
         9wdDmSxiOmJtU5DCyEOHjJdgwQGflCxONnnGmXFc=
Date:   Fri, 28 Oct 2022 12:33:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10 1/1] vdec_vp9_if: add check for NULL for
 vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
Message-ID: <Y1uwD66oqzLGufuq@kroah.com>
References: <20221028100539.30925-1-abelova@astralinux.ru>
 <20221028100539.30925-2-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028100539.30925-2-abelova@astralinux.ru>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:05:39PM +0300, Anastasia Belova wrote:
> If vsi->frm_bufs[vsi->new_fb_idx].buf.fb == NULL while cleaning
> fb_free_list NULL-pointer is dereferenced.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> index d9880210b2ab..dea056689b48 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> @@ -512,7 +512,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
>  	 * clean fb_free_list
>  	 */
>  	if (vsi->frm_bufs[vsi->new_fb_idx].ref_cnt == 0) {
> -		if (!vp9_is_sf_ref_fb(
> +		if (vsi->frm_bufs[vsi->new_fb_idx].buf.fb != NULL && !vp9_is_sf_ref_fb(
>  			inst, vsi->frm_bufs[vsi->new_fb_idx].buf.fb)) {
>  			struct vdec_fb *fb;
>  
> -- 
> 2.30.2
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
