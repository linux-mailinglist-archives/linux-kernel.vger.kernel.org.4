Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF264905C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 20:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLJTNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 14:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLJTND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 14:13:03 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E8D1580F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 11:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fl5MctCQk0LC4pWHcXHbWejyc3vm1182BaiSiZMxkg8=; b=mSx4iEOB8tyHhBRmNprwoholj1
        s+Vnhc0Th/XERxTkM+iHdIooS6Lpru4Bb97XyZGetaevmlOntTflD1ulUXVUMHivhrIDggjskpznL
        TqPy21t86S2lMua6jy5YVEV5XL3aTz3gT1/btJZywFWD0qMtKlghA6uWG1mlqsjCpG/mnVLdrG4FP
        qAqh2RNEHXj87njDimLIAK3eyiwPN0GzJSNPeEoE3Sgz6T3SNtnlmOi9uklm8mo1yPhkvDC8BLb4U
        CCg3o4cgrCgHrT5du5wMIysMOWQQ1DLenSy/x5nTyo6MsMMfKidCCIN4VobaaFyUSnUylhN6qOBxE
        YIOmWZMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p45HO-00Araa-1F;
        Sat, 10 Dec 2022 19:12:58 +0000
Date:   Sat, 10 Dec 2022 19:12:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH] fs: sysv: Fix sysv_nblocks() returns wrong value
Message-ID: <Y5TaOt0NLnB/h6QM@ZenIV>
References: <20221209100448.176857-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209100448.176857-1-chenzhongjin@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 06:04:48PM +0800, Chen Zhongjin wrote:
> sysv_nblocks() returns 'blocks' rather than 'res', which only counting
> the number of triple-indirect blocks and causing sysv_getattr() gets a
> wrong result.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  fs/sysv/itree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> index d4ec9bb97de9..3b8567564e7e 100644
> --- a/fs/sysv/itree.c
> +++ b/fs/sysv/itree.c
> @@ -438,7 +438,7 @@ static unsigned sysv_nblocks(struct super_block *s, loff_t size)
>  		res += blocks;
>  		direct = 1;
>  	}
> -	return blocks;
> +	return res;
>  }
>  
>  int sysv_getattr(struct user_namespace *mnt_userns, const struct path *path,

Argh...

To quote historical tree:
commit 0fcd426de9d02175c9771ea19f972389eeba7688
Author: Andries E. Brouwer <andries.brouwer@cwi.nl>
Date:   Sun Aug 22 00:07:46 2004 -0700

    [PATCH] minix block usage counting fix
    
    In 2.5.18 some minix-specific stuff was moved to the minix subdirectory
    where it belonged.  However, a typo crept in, causing inode disk usage
    to be incorrectly reported.  A few people have complained, but so far
    not sufficiently loudly.
    
    Signed-off-by: Andries Brouwer <Andries.Brouwer@cwi.nl>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index f8e9bd831c90..5a4b51dbfcb3 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -358,5 +358,5 @@ static inline unsigned nblocks(loff_t size)
                res += blocks;
                direct = 1;
        }
-       return blocks;
+       return res;
 }


This is obviously the sysvfs counterpart, not noticed back then and
not caught in 18 years since then...

Mea culpa - the original bug (both in minixfs and sysvfs) is mine and
I should've thought to look for sysvfs counterpart when minixfs fix
got posted.

Applied.
