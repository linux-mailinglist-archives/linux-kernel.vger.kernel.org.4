Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCAD69BA98
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 16:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBRPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 10:19:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C3715546;
        Sat, 18 Feb 2023 07:19:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b22so1367224lfv.5;
        Sat, 18 Feb 2023 07:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7q2Wg8S1rsfm30D7lgChP+RGLUmdPuKtGfy28d6nd2c=;
        b=Q+twZu/73PHUCZPn32nq0NgKH/rksz15uwZZFZqEIxVuq7cBUyB91DH9OFAkMhBZOZ
         25h4g1NLayShc27rvbNVkiohaUxWtzE8Ggc//EMsxd0HqhYXAftPtFojX5+lMfYHVmZP
         PXwIF10DE36X0lJNd/UsoMy2vlQlsUWT723LH09UTQtZIZ5aY8aqRnWSOc8UiAPiTTHL
         6fIoa9Gu54FZZWDRIEkiZg9RjNn0g++x8pTqJQIWfc0noFCtrvbfU715AePLjKoxCX/E
         If9AQx/7mZzIXoR9JgsZxE6WL3X9vbb3g5vMu2bVZDVCz12eYAHutrUL1o0GgMiFB4sZ
         LJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7q2Wg8S1rsfm30D7lgChP+RGLUmdPuKtGfy28d6nd2c=;
        b=MR5cPGrk3ycy9gZudMWBmZEpeiMS6ckbbna4uvnRwQrPqf36dMa4hC/ZvUEvpQPKwo
         o65TuVGzs4vrk57pi8mHY77wsKkSLPW4gy6MA4TYXKQG9NP816JB3bL3c86gni0B5UNd
         4BsF/jcpH/hwAH4uxNVtLUpVrhCayvGRayqon0/4r7H7FcHzeCKKY1+7TvCR7egxe37T
         X+OWjOtp8zfQGS4OzJFiAST2/gGTfGS8JdGwxNMjL/hP/HggBGEg70Mq10oQVDw4XCRd
         WjXb0kwoyjvxHtsA+u6XKOTHxLf4yWfzRkgqJzFWnas5wcNLK6mgyAhqF6L2MMhFKBY4
         UxsA==
X-Gm-Message-State: AO0yUKU6aT8dTP7DIfV/S44m6WoHAI09YJMXDFfzZLJmzvMlbI/VLdH/
        1fG4NCscwiOKCaMGty8m+ohNDiXVbXzrLFm/LZhZRaON
X-Google-Smtp-Source: AK7set9O89dNDCkMb+Ei/ZIH686OBETFP2ZLwTaSTkzyJBNq3dib4fxm87Hu9j1qs5CFBv5i1vz4rqvnBjNPBHRTCvQ=
X-Received: by 2002:a05:6512:501:b0:4d5:ca32:7bc3 with SMTP id
 o1-20020a056512050100b004d5ca327bc3mr1349945lfb.10.1676733577507; Sat, 18 Feb
 2023 07:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20230218002436.give.204-kees@kernel.org> <CAKYAXd9Y+wCbAy3a_W55fgb2Sy7M9UQUhR+XujaTKZ255YCjGg@mail.gmail.com>
In-Reply-To: <CAKYAXd9Y+wCbAy3a_W55fgb2Sy7M9UQUhR+XujaTKZ255YCjGg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 18 Feb 2023 09:19:26 -0600
Message-ID: <CAH2r5msJ1ZogypaiiLQ=STiroEXULwJr71_ta_+ZamXSqzxgpA@mail.gmail.com>
Subject: Re: [PATCH v3] smb3: Replace smb2pdu 1-element arrays with flex-arrays
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next pending testing

On Fri, Feb 17, 2023 at 9:24 PM Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> 2023-02-18 9:24 GMT+09:00, Kees Cook <keescook@chromium.org>:
> > The kernel is globally removing the ambiguous 0-length and 1-element
> > arrays in favor of flexible arrays, so that we can gain both compile-time
> > and run-time array bounds checking[1].
> >
> > Replace the trailing 1-element array with a flexible array in the
> > following structures:
> >
> >       struct smb2_err_rsp
> >       struct smb2_tree_connect_req
> >       struct smb2_negotiate_rsp
> >       struct smb2_sess_setup_req
> >       struct smb2_sess_setup_rsp
> >       struct smb2_read_req
> >       struct smb2_read_rsp
> >       struct smb2_write_req
> >       struct smb2_write_rsp
> >       struct smb2_query_directory_req
> >       struct smb2_query_directory_rsp
> >       struct smb2_set_info_req
> >       struct smb2_change_notify_rsp
> >       struct smb2_create_rsp
> >       struct smb2_query_info_req
> >       struct smb2_query_info_rsp
> >
> > Replace the trailing 1-element array with a flexible array, but leave
> > the existing structure padding:
> >
> >       struct smb2_file_all_info
> >       struct smb2_lock_req
> >
> > Adjust all related size calculations to match the changes to sizeof().
> >
> > No machine code output or .data section differences are produced after
> > these changes.
> >
> > [1] For lots of details, see both:
> >
> > https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> >     https://people.kernel.org/kees/bounded-flexible-arrays-in-c
> >
> > Cc: Steve French <sfrench@samba.org>
> > Cc: Paulo Alcantara <pc@cjr.nz>
> > Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> > Cc: Shyam Prasad N <sprasad@microsoft.com>
> > Cc: Tom Talpey <tom@talpey.com>
> > Cc: Namjae Jeon <linkinjeon@kernel.org>
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: linux-cifs@vger.kernel.org
> > Cc: samba-technical@lists.samba.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
>
> Thanks!



-- 
Thanks,

Steve
