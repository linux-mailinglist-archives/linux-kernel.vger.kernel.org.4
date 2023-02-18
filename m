Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509169B7E3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 04:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBRDWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 22:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRDWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 22:22:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459A23C7B;
        Fri, 17 Feb 2023 19:22:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18B74B82F37;
        Sat, 18 Feb 2023 03:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40EDC4339E;
        Sat, 18 Feb 2023 03:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676690555;
        bh=NvM8rMX7vszmzZ13cFwLKAQaASG65dDWzi5/WCQTomE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CE0rrKuOS3SuJ9R0TWg2MNjvLadgNh+Bt1n2s2WGloPLG3gCtCJiTGQ/EkrGjiFuw
         xFaGyZz2yyYe+Oh3P5OwRmAOgOIhD4ounADO0VxgTm25NAzzOlllt3Bo9YEYUH/fXJ
         TPnCiNNygf0Rb+6p1VAffEXzontneXzsvHUWUbzULI595U8KaUvlNLeA6synTIitNA
         BjfOkC+Lv7tvfg9gsTLrEMN1sL0pqwxPxaZmu7t6NbinQYJtksa/EDZEpJGyHitbK3
         Bju0+w1Weke/G9vRxVpTR2COAdzB/xHUMxXbUT1X5IzT0LrUr1rtANingaqJ5z63Yp
         YOlIIJrniQ8eA==
Received: by mail-oi1-f182.google.com with SMTP id bg20so2658308oib.9;
        Fri, 17 Feb 2023 19:22:35 -0800 (PST)
X-Gm-Message-State: AO0yUKUvSnPiL9OPs1XQGKH18wnRNBGlM5g9tjO7n0MFoQMxZxz7NepU
        uiv4dIA9WaXDJuAVkrUeNGqD9I2Gm7+aAIXvjxI=
X-Google-Smtp-Source: AK7set/XiooE4fdic8DHDR2MO1lKg50DpTkthOAR8RCDo+fI51RFAecJ7GKfs86cRk4RchcreGuAjfy61GhJ8UyaBkY=
X-Received: by 2002:a05:6808:20aa:b0:37f:8c73:4218 with SMTP id
 s42-20020a05680820aa00b0037f8c734218mr916992oiw.253.1676690554761; Fri, 17
 Feb 2023 19:22:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:78d8:0:b0:49f:f8ae:2ce5 with HTTP; Fri, 17 Feb 2023
 19:22:34 -0800 (PST)
In-Reply-To: <20230218002436.give.204-kees@kernel.org>
References: <20230218002436.give.204-kees@kernel.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 18 Feb 2023 12:22:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Y+wCbAy3a_W55fgb2Sy7M9UQUhR+XujaTKZ255YCjGg@mail.gmail.com>
Message-ID: <CAKYAXd9Y+wCbAy3a_W55fgb2Sy7M9UQUhR+XujaTKZ255YCjGg@mail.gmail.com>
Subject: Re: [PATCH v3] smb3: Replace smb2pdu 1-element arrays with flex-arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-02-18 9:24 GMT+09:00, Kees Cook <keescook@chromium.org>:
> The kernel is globally removing the ambiguous 0-length and 1-element
> arrays in favor of flexible arrays, so that we can gain both compile-time
> and run-time array bounds checking[1].
>
> Replace the trailing 1-element array with a flexible array in the
> following structures:
>
> 	struct smb2_err_rsp
> 	struct smb2_tree_connect_req
> 	struct smb2_negotiate_rsp
> 	struct smb2_sess_setup_req
> 	struct smb2_sess_setup_rsp
> 	struct smb2_read_req
> 	struct smb2_read_rsp
> 	struct smb2_write_req
> 	struct smb2_write_rsp
> 	struct smb2_query_directory_req
> 	struct smb2_query_directory_rsp
> 	struct smb2_set_info_req
> 	struct smb2_change_notify_rsp
> 	struct smb2_create_rsp
> 	struct smb2_query_info_req
> 	struct smb2_query_info_rsp
>
> Replace the trailing 1-element array with a flexible array, but leave
> the existing structure padding:
>
> 	struct smb2_file_all_info
> 	struct smb2_lock_req
>
> Adjust all related size calculations to match the changes to sizeof().
>
> No machine code output or .data section differences are produced after
> these changes.
>
> [1] For lots of details, see both:
>
> https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
>     https://people.kernel.org/kees/bounded-flexible-arrays-in-c
>
> Cc: Steve French <sfrench@samba.org>
> Cc: Paulo Alcantara <pc@cjr.nz>
> Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
