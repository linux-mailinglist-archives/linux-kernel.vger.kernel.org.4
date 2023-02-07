Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524AE68D727
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjBGMs0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Feb 2023 07:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBGMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:48:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91765AD04;
        Tue,  7 Feb 2023 04:48:22 -0800 (PST)
Received: from frapeml500006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PB2rN2XLRz6J6fN;
        Tue,  7 Feb 2023 20:44:20 +0800 (CST)
Received: from frapeml500005.china.huawei.com (7.182.85.13) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Feb 2023 13:48:20 +0100
Received: from frapeml500005.china.huawei.com ([7.182.85.13]) by
 frapeml500005.china.huawei.com ([7.182.85.13]) with mapi id 15.01.2507.017;
 Tue, 7 Feb 2023 13:48:20 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the integrity tree
Thread-Topic: linux-next: build failure after merge of the integrity tree
Thread-Index: AQHZOo5Tct5gClMYeE2iR8mZbs+mTq7DbyMw
Date:   Tue, 7 Feb 2023 12:48:19 +0000
Message-ID: <b02ea122f029407099950c5a0a8b935d@huawei.com>
References: <20230207115113.21efd917@canb.auug.org.au>
In-Reply-To: <20230207115113.21efd917@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Tuesday, February 7, 2023 1:51 AM
> Hi all,
> 
> After merging the integrity tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> security/integrity/ima/ima_main.c: In function 'ima_file_mprotect':
> security/integrity/ima/ima_main.c:473:34: error: implicit declaration of
> function 'file_mnt_user_ns'; did you mean 'get_user_ns'? [-Werror=implicit-
> function-declaration]
>   473 |         action |= ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
>       |                                  ^~~~~~~~~~~~~~~~
>       |                                  get_user_ns
> security/integrity/ima/ima_main.c:473:34: error: passing argument 1 of
> 'ima_get_action' makes pointer from integer without a cast [-Werror=int-
> conversion]
>   473 |         action |= ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                  |
>       |                                  int
> In file included from security/integrity/ima/ima_main.c:30:
> security/integrity/ima/ima.h:258:38: note: expected 'struct mnt_idmap *' but
> argument is of type 'int'
>   258 | int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
>       |                    ~~~~~~~~~~~~~~~~~~^~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   4958db3245fa ("ima: Introduce MMAP_CHECK_REQPROT hook")
> 
> interacting with commit
> 
>   39f60c1ccee7 ("fs: port xattr to mnt_idmap")
> 
> from the vfs-idmapping tree.
> 
> I have applied the following merge fix patch for today.

Hi Stephen

the fix looks ok for me.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 7 Feb 2023 11:31:16 +1100
> Subject: [PATCH] fixup for "ima: Introduce MMAP_CHECK_REQPROT hook"
> 
> interacting with "fs: port xattr to mnt_idmap"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  security/integrity/ima/ima_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index 7a05af9f481f..d66a0a36415e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -470,7 +470,7 @@ int ima_file_mprotect(struct vm_area_struct *vma,
> unsigned long prot)
>  	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
>  				current_cred(), secid, MAY_EXEC,
> MMAP_CHECK,
>  				&pcr, &template, NULL, NULL);
> -	action |= ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
> +	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
>  				 current_cred(), secid, MAY_EXEC,
>  				 MMAP_CHECK_REQPROT, &pcr, &template,
> NULL,
>  				 NULL);
> --
> 2.35.1
> x
> --
> Cheers,
> Stephen Rothwell
