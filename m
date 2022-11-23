Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A16361E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiKWOdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbiKWOdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:33:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADFC9590
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:33:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D471561D4D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D46EC433C1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669213988;
        bh=DNznwhHONJufkLNZpLKNvqDpPV1Ij4Mx/vGWHZOPeIg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EIPmfLJUisrkKvHe2iXo90ZexYgcz9YRxZ5hujwxkEOBzqpfrOl0slvAaPLtmeW/Q
         s0Pe1Hc/CZg+Bm47ytXRZ3qjsssILr4ZaBCHYGXcdAIhV7NLVbr3U7PgjcWTPwVmgp
         ifqVcob7YblDcx8JdyzVFmj3YX3sWhY3BLOoPehaSM71z01V4Yk8wxTWYHuhVXSa9S
         lA9WhlQVDzeu838yzpS7gVQog/yah5NrGoABAo/pRv+WPtcSwOY8MuoDruw+8yZN28
         pZm87NpjmOgdkchVZEQAz0k/5G3FhSOF6LxL6BWZ0L9WEZYr9KrjCbWzY+evPscEBE
         wTP4dH6aB15uA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-39ce6773248so106089127b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:33:08 -0800 (PST)
X-Gm-Message-State: ANoB5pmNfHDemdX9TYxrox/v22u7acjA/xBg9uxk9I35ur2KMYocSmEy
        h53RKUsYFaNSTKLdfQtGRFVENs9kGFVsRMwz4wM=
X-Google-Smtp-Source: AA0mqf528dbACy5MPaO6kowlGrU/IPBlyMm2GRODCjj7QCP1NDH1c23yv+yf1nivorEacclKYJ8ZO7+2q/eUX43qiNQ=
X-Received: by 2002:a0d:c542:0:b0:370:2d8c:8193 with SMTP id
 h63-20020a0dc542000000b003702d8c8193mr8500076ywd.221.1669213987310; Wed, 23
 Nov 2022 06:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20221123085640.103084-1-marpagan@redhat.com>
In-Reply-To: <20221123085640.103084-1-marpagan@redhat.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 23 Nov 2022 16:32:41 +0200
X-Gmail-Original-Message-ID: <CAFCwf12yeyMb3WgCPqb8sFUk5PmzrXU=sCf3oWG9FKdCCS_S1w@mail.gmail.com>
Message-ID: <CAFCwf12yeyMb3WgCPqb8sFUk5PmzrXU=sCf3oWG9FKdCCS_S1w@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/gaudi2: added memset for the cq_size register
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:59 AM Marco Pagani <marpagan@redhat.com> wrote:
>
> The clang-analyzer reported a warning: "Value stored to
> 'cq_size_addr' is never read".
>
> The cq_size register of dcore0 is not being zeroed using
> gaudi2_memset_device_lbw(), along with the other cq_* registers,
> even though the corresponding cq_size_addr variable is set.
>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/misc/habanalabs/gaudi2/gaudi2.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> index 65e6cae6100a..05f30adefb32 100644
> --- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
> +++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> @@ -9165,6 +9165,7 @@ static void gaudi2_restore_user_sm_registers(struct hl_device *hdev)
>         gaudi2_memset_device_lbw(hdev, cq_lbw_data_addr, size, 0);
>         gaudi2_memset_device_lbw(hdev, cq_base_l_addr, size, 0);
>         gaudi2_memset_device_lbw(hdev, cq_base_h_addr, size, 0);
> +       gaudi2_memset_device_lbw(hdev, cq_size_addr, size, 0);
>
>         cq_lbw_l_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0 + DCORE_OFFSET;
>         cq_lbw_h_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0 + DCORE_OFFSET;
> --
> 2.38.1
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
