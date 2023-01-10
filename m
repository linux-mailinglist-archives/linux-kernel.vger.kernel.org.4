Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE93663CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbjAJJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbjAJJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:27:22 -0500
X-Greylist: delayed 547 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 01:27:01 PST
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC69FBF52
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:27:01 -0800 (PST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 09E382055FA0;
        Tue, 10 Jan 2023 18:17:54 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 30A9HqZJ104126
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 18:17:53 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 30A9HqOf370631
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 18:17:52 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 30A9HqOn370630;
        Tue, 10 Jan 2023 18:17:52 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: Fix return value of vfat_bad_char() and
 vfat_replace_char() functions
In-Reply-To: <20221226142512.13848-1-pali@kernel.org> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message
        of "Mon, 26 Dec 2022 15:25:12 +0100")
References: <20221226142512.13848-1-pali@kernel.org>
Date:   Tue, 10 Jan 2023 18:17:52 +0900
Message-ID: <87zgaqu4sf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> These functions returns boolean value not wide character.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>

Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/namei_vfat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 21620054e1c4..0735e4f0aeed 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -200,7 +200,7 @@ static const struct dentry_operations vfat_dentry_ops = {
>  
>  /* Characters that are undesirable in an MS-DOS file name */
>  
> -static inline wchar_t vfat_bad_char(wchar_t w)
> +static inline bool vfat_bad_char(wchar_t w)
>  {
>  	return (w < 0x0020)
>  	    || (w == '*') || (w == '?') || (w == '<') || (w == '>')
> @@ -208,7 +208,7 @@ static inline wchar_t vfat_bad_char(wchar_t w)
>  	    || (w == '\\');
>  }
>  
> -static inline wchar_t vfat_replace_char(wchar_t w)
> +static inline bool vfat_replace_char(wchar_t w)
>  {
>  	return (w == '[') || (w == ']') || (w == ';') || (w == ',')
>  	    || (w == '+') || (w == '=');

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
