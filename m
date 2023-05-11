Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255016FED38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbjEKH4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjEKH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC0B4218
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C42F615F8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69344C433A7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683791752;
        bh=Ee6CqD05l0SiT8ZITLwZUEkw+FY3HNQg9i3z6kZzgzU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QqtxcEeayyeWyqXpOcNbOf4PObo5zx3qTzh8+FMMRcBnh3t+/j5i8Y/jH4pJ6qUG+
         aoqIzIFEuRrBhTqg/VWYZh1RfYwoNb1U8DkjMw/BvatJeOIa9Pba91z+PFkDI0KARr
         C+XH6DFmLoLJ5BG43jAiJInZH4yxM+9CGuJa+X7oCZGWGvhy6A/vBI9EdWFCSEkUPn
         wqJG6RQXxg4eq0iXQByOFrjbASw+/UCUmOGHlspRAgAZaHPiF06IWQzm/SSV92GoEa
         rHhn8fMDvXOmEcJsSU0TifcxbMXSErjqsFRY9pDxwVI+kqKGcZyG+sfEjsb3/BFV0y
         zpGJVUygB/o1A==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ab1942ea59so1997265a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:55:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDyOpSqOhMqA8ZOvTdLaHd+RV85E03gCYWpxE6hOQdEisIgCvbU1
        qqkei56wzxT+r8q5UsanJ66UfeBml+7AHpH45UI=
X-Google-Smtp-Source: ACHHUZ5QKdyusQlNfoFEyVt6NvreH/pSCh28lVRQWt6epudEY9lAaqfFuSFNQnOTc/oRcnX2Kz7QQhcoMgFZjLRqCSA=
X-Received: by 2002:aca:1c1a:0:b0:386:9720:77da with SMTP id
 c26-20020aca1c1a000000b00386972077damr3978338oic.26.1683791751414; Thu, 11
 May 2023 00:55:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:290:0:b0:4da:311c:525d with HTTP; Thu, 11 May 2023
 00:55:50 -0700 (PDT)
In-Reply-To: <20220829150309.GA26122@Negi>
References: <20220727001513.11902-1-soumya.negi97@gmail.com> <20220829150309.GA26122@Negi>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 11 May 2023 16:55:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Aizt2Ffz33ZRWp42Q51-Bs09cwvgXOidmiABaKmcKHA@mail.gmail.com>
Message-ID: <CAKYAXd-Aizt2Ffz33ZRWp42Q51-Bs09cwvgXOidmiABaKmcKHA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: Ensure $Extend is a directory
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-08-30 0:03 GMT+09:00, Soumya Negi <soumya.negi97@gmail.com>:
> On Tue, Jul 26, 2022 at 05:15:13PM -0700, Soumya Negi wrote:
>> Fix Syzbot bug: kernel BUG in ntfs_lookup_inode_by_name
>> https://syzkaller.appspot.com/bug?id=32cf53b48c1846ffc25a185a2e92e170d1a95d71
>>
>> Check whether $Extend is a directory or not( for NTFS3.0+) while
>> loading system files. If it isn't(as in the case of this bug where the
>> mft record for $Extend contains a regular file), load_system_files()
>> returns false.
>>
>> Reported-by: syzbot+30b7f850c6d98ea461d2@syzkaller.appspotmail.com
>> CC: stable@vger.kernel.org # 4.9+
>> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
>> ---
>> Changes since v1:
>> * Added CC tag for stable
>> * Formatted changelog to fit within 72 cols
>>
>> ---
>>  fs/ntfs/super.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
>> index 5ae8de09b271..18e2902531f9 100644
>> --- a/fs/ntfs/super.c
>> +++ b/fs/ntfs/super.c
>> @@ -2092,10 +2092,15 @@ static bool load_system_files(ntfs_volume *vol)
>>  	// TODO: Initialize security.
>>  	/* Get the extended system files' directory inode. */
>>  	vol->extend_ino = ntfs_iget(sb, FILE_Extend);
>> -	if (IS_ERR(vol->extend_ino) || is_bad_inode(vol->extend_ino)) {
>> +	if (IS_ERR(vol->extend_ino) || is_bad_inode(vol->extend_ino) ||
>> +	    !S_ISDIR(vol->extend_ino->i_mode)) {
>> +		static const char *es1 = "$Extend is not a directory";
>> +		static const char *es2 = "Failed to load $Extend";
>> +		const char *es = !S_ISDIR(vol->extend_ino->i_mode) ? es1 : es2;
>> +
>>  		if (!IS_ERR(vol->extend_ino))
>>  			iput(vol->extend_ino);
>> -		ntfs_error(sb, "Failed to load $Extend.");
>> +		ntfs_error(sb, "%s.", es);
>>  		goto iput_sec_err_out;
>>  	}
>>  #ifdef NTFS_RW
>> --
>> 2.17.1
>
> Hi Anton,
> Have you had a chance to look at this patch?
Hi,

Could you elaborate more ? Isn't MFT_RECORD_IS_DIRECTORY flags set in
mft record of $Extend ?

> Thanks,
> Soumya
>
>
