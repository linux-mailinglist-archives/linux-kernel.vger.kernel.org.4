Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC25699758
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjBPOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBPOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:25:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9002497F4;
        Thu, 16 Feb 2023 06:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97080B8284E;
        Thu, 16 Feb 2023 14:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DFDC433A1;
        Thu, 16 Feb 2023 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676557503;
        bh=DlaFGPI8/PtG0jbRs8yDMyRigvxWoADQdFPsFBEUvVM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jtPb9BXfoJ4ZIuteko19xvEHrh0zX9vL+hj21bb6i9YloP5XD4j0AzdYnrNw/r1cV
         irTY1qdNbSU6KHCtRGYajBsFTXo5RihWxDt6qmzyEG/tlAiIKA4VZCyuxIb8zXfcK+
         7b2C8p1C/NXEgYNStB11TWeq4NWj4fYRYDI2TSJyarB99J32scKwyTeeNvGxYb5tbJ
         pwB/9qiPeh4iOe9T+t+ydQDl2em2wxZhNTyvrNXc3PoOlvZDWYsdN0QPZ6bXDtrNe4
         TsGw1SfbYUDD4aVR7dyDpsy2RIfLhXPdkbuVMKOZMUtNPy6n0WsQ0DpNVHD+Zyj8XL
         EEuI/zj4uTO9w==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-16df32f2ffdso2726411fac.1;
        Thu, 16 Feb 2023 06:25:03 -0800 (PST)
X-Gm-Message-State: AO0yUKUzMsLcMiAqD1Tq1QlfVrxfye0o16DPxKnyGWwASPJj7n7mLIN6
        8UaCreNYbyE2k8+q8hmfqZgefKgV+CJzdoEC99Q=
X-Google-Smtp-Source: AK7set/YDnoRsXFW4kmp4obtqoSrpLbMekh5OLqyPQitghf4s397JCGpwBcy4mlMZ5KbG30FMsXw3/Lnue0SZ0ll3J0=
X-Received: by 2002:a05:6870:b52c:b0:16a:b198:74e9 with SMTP id
 v44-20020a056870b52c00b0016ab19874e9mr194278oap.215.1676557502403; Thu, 16
 Feb 2023 06:25:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Thu, 16 Feb 2023
 06:25:01 -0800 (PST)
In-Reply-To: <20230214232928.gonna.714-kees@kernel.org>
References: <20230214232928.gonna.714-kees@kernel.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 16 Feb 2023 23:25:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-fcukmXfdwiAxOxe+5c+Y6vvaoQ3ff-5sK+Zis0HgC5A@mail.gmail.com>
Message-ID: <CAKYAXd-fcukmXfdwiAxOxe+5c+Y6vvaoQ3ff-5sK+Zis0HgC5A@mail.gmail.com>
Subject: Re: [PATCH v2] smb3: Replace smb2pdu 1-element arrays with flex-arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        samba-technical@lists.samba.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

>  /* Read flags */
> @@ -730,7 +730,7 @@ struct smb2_read_rsp {
>  	__le32 DataLength;
>  	__le32 DataRemaining;
>  	__le32 Flags;
> -	__u8   Buffer[1];
> +	__u8   Buffer[];
>  } __packed;
>

You seem to have missed -1 removal in the code below.

./fs/cifs/smb2ops.c:5632:       .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/cifs/smb2ops.c:5654:       .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/cifs/smb2ops.c:5675:       .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/cifs/smb2ops.c:5696:       .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/cifs/smb2ops.c:5717:       .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/cifs/smb2ops.c:5738:       .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/cifs/smb2ops.c:5759:       .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,

./fs/ksmbd/smb2ops.c:29:        .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/ksmbd/smb2ops.c:55:        .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/ksmbd/smb2ops.c:82:        .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,
./fs/ksmbd/smb2ops.c:109:       .read_rsp_size = sizeof(struct
smb2_read_rsp) - 1,

thanks.
