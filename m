Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E16466F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiLHC1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLHC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:27:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790313CE4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nitoRDSbyPuxvWVtO799Uvaij9lRlhu61rb1nL17EDjiCHvKu48FT5OjU3sbGhIJ/PbLjI2JjRhY7IBTjzi4pxhkAbghdtT9AmumbjpzDhpde7eXBxTwzJO6YJuYSs4XpLkZrAGQ3cGRoTOuTIoQkPaeXywCc+CMiP5NbFMcQJE05VmdmrMeVtCS7/GGcDsZ9Z1o2Wm7SWEyDfpkFdfdDeANLu/JLQIn6Nt14QHW5UG9+eews7sdDmb2cccdxKxvqCsjAR5gHG5p/rGWUxHRMgiIg3YZGAcvmjh4WddL/D0oeilcZq7xsy7Y5gAoV88uVbgwCr2zHmrmOj9y+Etiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdoa9y69mXXGjQfWWtkPtvumDpGsHjUX4HaerkUp3RE=;
 b=jzrI4/3DFVu+rSpdQ5pfVYsPzJunPngXdWQ75oGYL8TYCS5u0/ISC8SpeMgYlluGeD5vLxQyHZGb5Ui1kBZ8cIRG3v+uNILkkLlwDPxMP4MoZORVYByWHvShfkncz+PiPvUO5vluXKCmPaCJ6uJdBp9DQt0W4qv+WVOkIKdn4BzduharR9EYsyAp/o9DHuohvU6gqPgdsm5gygmFPOp5/yw06jtuD2rbf4NmRBsBlUI5kbve9J6NtRQQC42Ksx8cLJmgoymLyRJXJr4NYBEaQMhcRQFem1Tkrqt2LcQmslr7GdCwoUiwS7/JmVOPnRnNHqvNLAU6nZAjeFhN5lN/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdoa9y69mXXGjQfWWtkPtvumDpGsHjUX4HaerkUp3RE=;
 b=C+tnESFATnlRVSg36JCymKtaoZZ6iyXSgrJ2kspRLm7lMn03s0JKsn4nepq6LmlkvjI8XzJ+si8Pd/0uMAHVezHTMHvPSF1GWXrXXq8wI+sRANAAAOv2iizJVcK+YXHG47DQhwcmt5uWraXpy7NayY7vZBXfZHuuCTOYFSfcmAJ4TtqpHjHYN8+Jh8caKdkUoSzJvNA1LbcdMPBlA9zknihBm7Vd+AGiDtI9u2TXkbL2d+jcRTZ74eSxdz77p9W8qdgMqfVTfjPOv+9mY4uxpm2DOjZpQ6/aSvj77QPJnkak5MiA9IFW/hBOWuQUxeF49G4+6TiGvu9Z7Obru++rKg==
Received: from DM6PR14CA0069.namprd14.prod.outlook.com (2603:10b6:5:18f::46)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 02:27:42 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::25) by DM6PR14CA0069.outlook.office365.com
 (2603:10b6:5:18f::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 02:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 02:27:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 18:27:30 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 18:27:30 -0800
Message-ID: <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
Date:   Wed, 7 Dec 2022 18:27:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <willy@infradead.org>,
        <tsahu@linux.ibm.com>, <david@redhat.com>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 7475e76b-4ad7-4513-32e5-08dad8c3c89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTUjpcFP+XW0J136e5qzvyOoEG45UtE8ft6a3/itpQlbarusIvNvIP837UyKGdDZl8WbRHsd0r9Rj/ZFl3NfZ4naX1j2vX8pnRy8MiGmN7YAk9A/v/VSU65J1IYlycQJhihNtSSLvDXcqsWzUvZRglRgIUCYt7sRg4mPJFTwn7ahq+aJNWdmXRwoxJC9L5XkkBXdnNiX83RdNW9exVuUKb/s9Bj0Q2/EkMD20mT+4/W2/TI9CN7zbYN2fx9WzhTSNgU69wLP0aYlUA8Zwl+Ul7R52RUVvlHpMqlatWv7ikf3ZU11tqo2DPBKHXfleHo4WpqbnKv/ombajn9jBD9TZVuhW/xE4lehZhOckq7AMCmdSCTQKTYNI9K/Q1fkQ8/dzd5T6eZOPGDY1/b1j09EUKucvdELHub/nYmfzzbUeWZf6kh3NfPKIqRP6kV6Vl/9/lrPK65iXVuk3oieQ84DXGfqyM8DwBFuw5oGZ07Fi/hTviKqbpmrkOnoWLyfY+mFmjWaXO0Nz8O9noZEtKVXqz+fVG5u3Cvsp5RQUSKv3PJk50vAy72EHJCnL0T7peEIm6qPWM6EnRnmdkEppCTXPfk/MG8xWJ9/MAPFY/sNKoqIkf1zN8EliEaHhwqMjZpiZGqXGYGSI16y8wPk35MbTGiexWkspUbm80yCM5XQ0D/ipJ9g6thlOh83gENsBaAFdCuPeveRKkzkU7ohv5NLcuzuGPW+7nEcWWqXy6zizkN9OepymLwN2qFI5FUNN2tx
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(31696002)(41300700001)(36756003)(70206006)(16526019)(186003)(40480700001)(40460700003)(70586007)(86362001)(336012)(4326008)(8936002)(8676002)(5660300002)(47076005)(2616005)(316002)(16576012)(53546011)(54906003)(426003)(478600001)(110136005)(7636003)(356005)(26005)(82310400005)(82740400003)(36860700001)(2906002)(83380400001)(31686004)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 02:27:42.0751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7475e76b-4ad7-4513-32e5-08dad8c3c89d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 17:42, Sidhartha Kumar wrote:
>> Wouldn't it be better to instead just create a new function for that
>> case, such as:
>>
>>      dissolve_large_folio()
>>
> 
> Prior to the folio conversion, the helper function __destroy_compound_gigantic_page() did:
> 
>      set_compound_order(page, 0);
> #ifdef CONFIG_64BIT
>      page[1].compound_nr = 0;
> #endif
> 
> as part of dissolving the page. My goal for this patch was to create a function that would encapsulate that segment of code with a single call of folio_set_compound_order(folio, 0). set_compound_order() does not set compound_nr to 0 when 0 is passed in to the order argument so explicitly setting it is required. I don't think a separate dissolve_large_folio() function for the hugetlb case is needed as __destroy_compound_gigantic_folio() is pretty concise as it is.
> 

Instead of "this is abusing function X()" comments, we should prefer
well-named functions that do something understandable. And you can get
that by noticing that folio_set_compound_order() collapses down to
nearly nothing in the special "order 0" case. So just inline that code
directly into __destroy_compound_gigantic_folio(), taking a moment to
fill in and consolidate the CONFIG_64BIT missing parts in mm.h.

And now you can get rid of this cruft and "abuse" comment, and instead
just end up with two simple lines of code that are crystal clear--as
they should be, in a "__destroy" function. Like this:


diff --git a/include/linux/mm.h b/include/linux/mm.h
index 105878936485..cf227ed00945 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1754,6 +1754,7 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
  #endif
  }
  
+#ifdef CONFIG_64BIT
  /**
   * folio_nr_pages - The number of pages in the folio.
   * @folio: The folio.
@@ -1764,13 +1765,32 @@ static inline long folio_nr_pages(struct folio *folio)
  {
  	if (!folio_test_large(folio))
  		return 1;
-#ifdef CONFIG_64BIT
  	return folio->_folio_nr_pages;
+}
+
+static inline void folio_set_nr_pages(struct folio *folio, long nr_pages)
+{
+	folio->_folio_nr_pages = nr_pages;
+}
  #else
+/**
+ * folio_nr_pages - The number of pages in the folio.
+ * @folio: The folio.
+ *
+ * Return: A positive power of two.
+ */
+static inline long folio_nr_pages(struct folio *folio)
+{
+	if (!folio_test_large(folio))
+		return 1;
  	return 1L << folio->_folio_order;
-#endif
  }
  
+static inline void folio_set_nr_pages(struct folio *folio, long nr_pages)
+{
+}
+#endif
+
  /**
   * folio_next - Move to the next physical folio.
   * @folio: The folio we're currently operating on.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e3500c087893..b507a98063e6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1344,7 +1344,8 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
  			set_page_refcounted(p);
  	}
  
-	folio_set_compound_order(folio, 0);
+	folio->_folio_order = 0;
+	folio_set_nr_pages(folio, 0);
  	__folio_clear_head(folio);
  }
  

Yes?

thanks,
-- 
John Hubbard
NVIDIA
