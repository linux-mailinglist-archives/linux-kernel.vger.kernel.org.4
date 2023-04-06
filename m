Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35D6D9062
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjDFHZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjDFHZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:25:37 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D67619F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:25:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 19C283200985;
        Thu,  6 Apr 2023 03:25:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Apr 2023 03:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680765933; x=
        1680852333; bh=mSLRY4bfvs6q0sv5lAC5YPzV1A9nS5DmWiDXnI5elus=; b=p
        hoIvuJvyXTomJUNCECIoOND4embs/OFpe127VUY/w8ay9PKck4ZKFAW6LEbc5Eyr
        PNVyQglyJlXNUvGQA/vacOJnKDYmAorJqSVw0tWeDUrIUIootVofjPseG44ZJanb
        6/s9Ui+Ze8Js09VOcli3fwnEpq4r5aydj/5abdR8vcYnexR4sS7o3cbUOK8jt5Qx
        dCNIY+CvOR3xwM6L7HWimGz2J5GYwPDjlSdw0RcofXR7qYDeve7P9MJtSnL4tnHN
        jkRtnvCO+EQpeEn7j7kxTXMAxgIb/FDJbb3tJTKSJHq7nrEW2dU+fKtKo6ltRCch
        IMeL82vBKjoUzedAx7XqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680765933; x=1680852333; bh=mSLRY4bfvs6q0
        sv5lAC5YPzV1A9nS5DmWiDXnI5elus=; b=rjCICZv68UQ8//r6X+ggawcCbpcC0
        eo2KC0pdHFLhejjC5YWUako56WK0k3zCHMaoEOamdjMw00AvNpoRDNutztoIihCi
        RlXEkKSV50mN6HeQerGO/cLVShelTTgBpwt0o5mG8a+V4/1B9QzHaID/itAOlNZo
        +MAjCDtlPgPWALPs/xlPMsdaC2Y+FLPrG6HkZNMtYaMKuh5NUc2esnq8A97OTgjo
        r5lb5Og8BKRcm83UrzXi/yfqEQajWZjuzTsZsqBQqLJKxLXY8GPA6kbMHOJwlSxf
        8pZ7jHh83zUyVQJUcUNNr7Wl+K6bKDjSWgxYvuihv6qzETH9+3F0oyV1w==
X-ME-Sender: <xms:7XMuZNkPJNBFbbMeIKuLO1ZamqcGaXJEbolEGTLgHVMNFi8JJ01fwQ>
    <xme:7XMuZI3RmRcAxBvQlVrJbmw6xxKsDCAN63G2EBiIs6iK5cYcu4y4WJ_Jk_XJ6AjIR
    p1vD61k2EJpDfXo6-o>
X-ME-Received: <xmr:7XMuZDo_H6oDqUZ-Pm2fSKgPZg7yzKdNmT8doA90r-DFgAubtb58eQuK6YMfjDtvjPB55A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejvddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dttddttddtvdenucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceo
    khhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeelgf
    fhfeetlefhveffleevfffgtefffeelfeduudfhjeduteeggfeiheefteehjeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:7XMuZNlzd1xyEYEHMDS4vXwB6QIDoh-m5MZXvzRF9f-e6yJnWsWY7A>
    <xmx:7XMuZL0NQeeyZZGwOvTFyrVGiQN64fsdHy7dOiOduhHTRmiEleKTYg>
    <xmx:7XMuZMtDLfptDNl9MMIBEihja_8CPMaFcEqFaGRkK70Ex_6qpdCctg>
    <xmx:7XMuZJA1B1NtDKDHhEuTxKuEL567g8_RmsoyBhPCTnjDPd0fClF_ww>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 03:25:33 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id BEF80102846; Thu,  6 Apr 2023 10:25:29 +0300 (+03)
Date:   Thu, 6 Apr 2023 10:25:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Message-ID: <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
References: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 10:20:26PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Mar 15, 2023 at 06:38:00PM +0300, Kirill A. Shutemov wrote:
> > fix min() warning
> > 
> > Link: https://lkml.kernel.org/r/20230315153800.32wib3n5rickolvh@box
> > Reported-by: kernel test robot <lkp@intel.com>
> >   Link: https://lore.kernel.org/oe-kbuild-all/202303152343.D93IbJmn-lkp@intel.com/
> > Signed-off-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> This patch results in various boot failures (hang) on arm targets
> in linux-next. Debug messages reveal the reason.
> 
> ########### MAX_ORDER=10 start=0 __ffs(start)=-1 min()=10 min_t=-1
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> If start==0, __ffs(start) returns 0xfffffff or (as int) -1, which min_t()
> interprets as such, while min() apparently uses the returned unsigned long
> value. Obviously a negative order isn't received well by the rest of the
> code.

Actually, __ffs() is not defined for 0.

Maybe something like this?

diff --git a/mm/memblock.c b/mm/memblock.c
index 7911224b1ed3..63603b943bd0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2043,7 +2043,11 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	int order;
 
 	while (start < end) {
-		order = min_t(int, MAX_ORDER, __ffs(start));
+		/* __ffs() behaviour is undefined for 0 */
+		if (start)
+			order = min_t(int, MAX_ORDER, __ffs(start));
+		else
+			order = MAX_ORDER;
 
 		while (start + (1UL << order) > end)
 			order--;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c8f0a8c2d049..3179c30f7958 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -605,7 +605,13 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	 * this and the first chunk to online will be pageblock_nr_pages.
 	 */
 	for (pfn = start_pfn; pfn < end_pfn;) {
-		int order = min_t(int, MAX_ORDER, __ffs(pfn));
+		int order;
+
+		/* __ffs() behaviour is undefined for 0 */
+		if (pfn)
+			order = min_t(int, MAX_ORDER, __ffs(pfn));
+		else
+			order = MAX_ORDER;
 
 		(*online_page_callback)(pfn_to_page(pfn), order);
 		pfn += (1UL << order);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
