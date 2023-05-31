Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2163A717B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjEaJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjEaJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:04:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA9135;
        Wed, 31 May 2023 02:04:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af31dc49f9so60311361fa.0;
        Wed, 31 May 2023 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685523889; x=1688115889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrtN/2a5JJTprBcYp9jvZ+UGojw4315OmIU8TzujPAw=;
        b=aGDLNuG8w9aRbKs613i2qng0wy6XdphgsO9DC+Qy40A8rrPXO9353ZgHVIohfsrRW6
         Y4ZtTXx+79iQm0YUYe89Vqp+5OVVe3+4Xqk2Jgb3dNc5kabutUgM4rsNjvbiuvMk63JL
         QXAnWJByUDNBgRAXdXmQCPcHzH5Q2bEGNspZwLuEFmy+EFcixV895frB3qBUU/ah+BnC
         CV1X5sG+lH4+m283ml9QcxW/0SU6vh1rQZTDqxGbuzfroAyrc33I/Zyg841loN91YQFG
         JmCL4pwEkJfwG2BbIXHG1FbSgpi1tNSY+JAsLI5foOekv+9fsfTF1HndjVO0nfoSUtby
         2JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523889; x=1688115889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrtN/2a5JJTprBcYp9jvZ+UGojw4315OmIU8TzujPAw=;
        b=hkRK9qBUPEyBlj/JYnQGFcIXrFWGYawxy54kIGdMmyDL8MskH5ICyRHUVBTTVN7ohD
         cHwafAJqWJFt1iLj6SORx6yp69eoJLekecgptOBgdKmoXVeEv3VDOGhbe6fqHNhvDxXH
         q+USx5h9U7NTbHSPw+fsasfTdtunBhNcl7zcntxL7JFVr2TpUCDuuN1ifcyaBCmYh+dW
         1lJjS55ZUPYSKTLgc7F2S6D1Dickc4XaMrFQ2BcAOT3ES07t1VUmZweKlR0ovhMWxCSe
         nrGdC3OJNKcq0CM9NvpJqGy7oLfGw8oeJ8+/QZYq5FR/S4a0TxjpfxwLgLtFWH704eXa
         kOkQ==
X-Gm-Message-State: AC+VfDxyLIo6zVCpXU8EVgebjUIj3FY+9Jb0l94d848cy//20YnIrISb
        7XnJIuElQ+Z2eymtxo4PLYuJ3CBv4EUWI2H99tBn4/z74Q==
X-Google-Smtp-Source: ACHHUZ6Q/b1Vd1sDwa9EpiwBHjkXj03DdqC6oi6LN/XlpOtPYWRjn5KHR1hRURuJRJou2lJKUENmn1RoQ1Y2NHNG4DY=
X-Received: by 2002:a2e:9e15:0:b0:2ac:8c95:d42b with SMTP id
 e21-20020a2e9e15000000b002ac8c95d42bmr2183665ljk.4.1685523888771; Wed, 31 May
 2023 02:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230531083828.8009-1-ed.tsai@mediatek.com>
In-Reply-To: <20230531083828.8009-1-ed.tsai@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 31 May 2023 17:04:36 +0800
Message-ID: <CAGaU9a_Aoyka-tNvG-WGAEacGgcF38gyHLcTLrK+mL_qGfwRwg@mail.gmail.com>
Subject: Re: blk-mq: check on cpu id when there is only one ctx mapping
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, liusong@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        peter.wang@mediatek.com, stanley.chu@mediatek.com,
        powen.kao@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 4:49=E2=80=AFPM Ed Tsai <ed.tsai@mediatek.com> wrot=
e:
>
> commit f168420 ("blk-mq: don't redirect completion for hctx withs only
> one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx, there
> will be no remote request.
>
> But for ufs, the submission and completion queues could be asymmetric.
> (e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
> ctx won't complete request on the submission cpu. In this situation,
> this nr_ctx check could violate the QUEUE_FLAG_SAME_FORCE, as a result,
> check on cpu id when there is only one ctx mapping.
>
> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
