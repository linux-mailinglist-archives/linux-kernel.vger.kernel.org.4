Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882B95B8EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiINSNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiINSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:13:41 -0400
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Sep 2022 11:13:39 PDT
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 844FB30F63
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:13:39 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 54BE82055F9C;
        Thu, 15 Sep 2022 03:05:34 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 28EI5Xub230832
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 03:05:34 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 28EI5WRn660022
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 03:05:33 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 28EI5WCh660021;
        Thu, 15 Sep 2022 03:05:32 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Gianfranco <gianfranco.dutka@arista.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     fat: device-level-flush-after-sync
In-Reply-To: <20220914174015.7158-1-gianfranco.dutka@arista.com> (Gianfranco's
        message of "Wed, 14 Sep 2022 10:40:14 -0700")
References: <20220914174015.7158-1-gianfranco.dutka@arista.com>
Date:   Thu, 15 Sep 2022 03:05:32 +0900
Message-ID: <874jx9x24z.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gianfranco <gianfranco.dutka@arista.com> writes:

>     This patch forces a device-level flush after the generic Linux
>     code for sync has run.
>
>     The kernel depends upon filesystem-specific code to flush when
>     the filesystem itself thinks it is necessary, and otherwise
>     does nothing.  Someone expecting sync to behave as expected
>     might be in for a rude surprise.
>
>     The usual caveats apply:  Devices that do not implement flush
>     or whose implementation is buggy will not behave well.  IO
>     that occurs after the sync will not be flushed.

Does this patch fix the issue? After the ->sync_fs(), bdev page caches
including FAT data are still dirty, isn't it?

Thanks.

> Signed-off-by: Ken Kofman <gianfranco.dutka@arista.com>
>
> ---
>  fs/fat/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index a38238d75c08..ddaed94ee48f 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -823,6 +823,14 @@ static int fat_remount(struct super_block *sb, int *flags, char *data)
>  	return 0;
>  }
>  
> +static int fat_sync_fs(struct super_block *sb, int wait)
> +{
> +	if (wait)
> +		return blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
> +	else
> +		return 0;
> +}
> +
>  static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct super_block *sb = dentry->d_sb;
> @@ -937,6 +945,7 @@ static const struct super_operations fat_sops = {
>  	.put_super	= fat_put_super,
>  	.statfs		= fat_statfs,
>  	.remount_fs	= fat_remount,
> +	.sync_fs        = fat_sync_fs,
>  
>  	.show_options	= fat_show_options,
>  };

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
