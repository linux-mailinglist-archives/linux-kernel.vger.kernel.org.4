Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CAC6BCD58
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCPK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCPK5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:57:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F5E1515B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:57:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 788DB1FE03;
        Thu, 16 Mar 2023 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678964221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcsL45yTzWpEz7M4IrwnonxWMd6jbVko6lid+dw5guM=;
        b=P5p+TY3lxhR5szMnytu15w1Plmw+h4QDg+4fbC0PcGG4tq/ejscaFVCMJoViHnYxykV6FO
        AOPgPjIeGIt7hRjU19tLtHNcIpg7qcDMLpEgGYW1ah8bPAEJ6jCN/PCmP8lUVTCVYgK1GR
        rHHZkvnHRMgU2ygQQLiwKmbzKEQq+xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678964221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcsL45yTzWpEz7M4IrwnonxWMd6jbVko6lid+dw5guM=;
        b=oxVk2TXL8V1Imw9QyW504uh26cv2Uv07hyxIb9GMOX4x/6uhaPgqxmmnz5DbOAWhicvLyO
        MA5SKuC3w7biI+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52C4813A2F;
        Thu, 16 Mar 2023 10:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HrZ2E/31EmTPcgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Mar 2023 10:57:01 +0000
Message-ID: <74f2ea6c-f1a9-6dd7-260c-25e660f42379@suse.cz>
Date:   Thu, 16 Mar 2023 11:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/10] mm/mmap: start distinguishing if vma can be removed
 in mergeability test
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-10-vbabka@suse.cz>
 <7e0e33a7-4e9b-4714-8d4b-9487c8d1f799@lucifer.local>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <7e0e33a7-4e9b-4714-8d4b-9487c8d1f799@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/15/23 23:05, Lorenzo Stoakes wrote:
> On Thu, Mar 09, 2023 at 12:12:57PM +0100, Vlastimil Babka wrote:
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -742,12 +742,13 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>
>>  /*
>>   * If the vma has a ->close operation then the driver probably needs to release
>> - * per-vma resources, so we don't attempt to merge those.
>> + * per-vma resources, so we don't attempt to merge those in case the caller
>> + * indicates the current vma may be removed as part of the merge.
> 
> Nit: 'in case the caller indicates' -> 'if the caller indicates'

Ok, -fix patch below.
 
...

>> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
>> +	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
>>  	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
>>  		pgoff_t vm_pglen;
>>  		vm_pglen = vma_pages(vma);
>> --
>> 2.39.2
>>
> 
> I wonder whether this might be moved later into the actual vma_merge() logic so
> we only abort a merge at the point a VMA with ->close() would otherwise be
> removed? But obviously that would probably need some further clean up to make it
> not add yet more complexity to an already very complicated bit of logic.

Yeah, can try that later to cover the remaining cases where
->close prevents merging unnecessarily.

> Otherwise, very nice, clear + conservative so,
> 
> Reviewed-By: Lorenzo Stoakes <lstoakes@gmail.com>

Thanks!

----8<----
From b8072720288491bdc887ebebbb099babcfb108a5 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 16 Mar 2023 11:54:27 +0100
Subject: [PATCH] mm/mmap: start distinguishing if vma can be removed in
 mergeability test-fix

Adjust comment as suggested by Lorenzo.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4259095a2982..b255e6352710 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -742,8 +742,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 /*
  * If the vma has a ->close operation then the driver probably needs to release
- * per-vma resources, so we don't attempt to merge those in case the caller
- * indicates the current vma may be removed as part of the merge.
+ * per-vma resources, so we don't attempt to merge those if the caller indicates
+ * the current vma may be removed as part of the merge.
  */
 static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 		struct file *file, unsigned long vm_flags,
-- 
2.39.2


