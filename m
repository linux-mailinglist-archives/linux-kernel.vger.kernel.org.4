Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93664F44C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLPW5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLPW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:57:06 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADCB6E9F6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDStdDbVlaMGEN9gptssgtBCUgoQ2GoiMZ+hwK+BMEXg3Mb6pl7ehvxzL/LPjf1W8H37DaLFiwnjoZhVDp12gNdAR54cFDqB6bg60WSEaUTAoWgVruxLC55oYmv9mm3Occ4rcmmfm6UVXpJRcWGzYcKEjSiUjFd10CGmBVAEiMtyRmKAYcemsnLbZQKEYzsQxGZEuYptcbFiVuysXf2/Cs3GIMU1HLYfhRRWuDuxCmKE1G6LpD4tpciU3Cv86col01rtSSNmSxnwaEcadNqnhpA0EX1H+uCcSbov+GN25HVW5aaHpPZfMjVDih/m3WaJcZwaK8JcJfP8GW1zVvVfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EUv0V4VM5gI0P51Kae8hR/xvnjEhuuKqx9LwiQ3CZE=;
 b=QXmhKvzMsHU+6Ru9Mv1v0qO4WZxAXbuHGOt0XV70az9oLrZu43Nv9cRyLS8p8MeALdUWzoZLfVoYA6+CT+5qUtXl4+YZa3pJ6zVoPO9TsIQlDVsEWQfa8vzn8MNpBJ77fHp5qGP+V1vtLN9yKTiJEU3Y1jmBzPluHGxz+s0DhiyGvs2VGGgqKoZCpJdRM4aOCf7dPc8ALJD56FziwNDAtiMzzayCWDrtuBa2L1WlQIsyMVH8hJdOIBWllcAWJ+4YvSmBUVMzEmCvIFwGx0LRc2EtO4ts/lAZEjrtVjYhfGntVHxGkOTlo+EyTtp8HtzN+P3N2S7l+yZrTdxrqrqQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EUv0V4VM5gI0P51Kae8hR/xvnjEhuuKqx9LwiQ3CZE=;
 b=OC3vwV/YRHKNzjG6TU+oa7AkShUKvQTQmSzfzt8UP6Px4zHlg/P2mpfksC8SeU9P+JnU+k4aJ168/q4WHwPTT8F+30kGf9pFCydywhL2tGjWFRau4Cudm2hQZhUQmsR6ZOfpzf1hRBMtScMv+ntK9lfEExRj3qLsGvAdgyGpQUQq41Tf+fnu7FynuZQXUjAwaoTrDhW20gbQvz4tVUKRdGb91wihoZoPbuTLNIcqntlm9jph2xGY8NK5rA+fTsG0swQdmRs8pofKvx6/sJ01+BxufqpafRwOheX0C/fLyLmukKEEFqkLWEmB73KKHmwF0y6eR1AfQ5W5WVe3msmGHA==
Received: from DS7PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:3af::16)
 by SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 22:57:03 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::f4) by DS7PR07CA0006.outlook.office365.com
 (2603:10b6:5:3af::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15 via Frontend
 Transport; Fri, 16 Dec 2022 22:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16 via Frontend Transport; Fri, 16 Dec 2022 22:57:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 14:56:49 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 14:56:48 -0800
Message-ID: <963ba9b4-6ddf-39bc-85cf-2feef542029d@nvidia.com>
Date:   Fri, 16 Dec 2022 14:56:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <willy@infradead.org>
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
 <20221216142733.e2a716a4cd7ea55240d98391@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221216142733.e2a716a4cd7ea55240d98391@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 6984869c-c414-4ca9-1245-08dadfb8d8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQI42SaBUUhEBcvYADue9fgarLuyuk6MAGuxC+5dr4C6nHvmcfh4kuWsKKRMk0+b51ZTk3Rp3PZK9jznbwLyG1ROmgwAJ99BbAB7g+Lqh7NFNAhWjJncw1AaTynyjz9eF2TYtNpxVSKKKK3C0UlP2zpwclF6p0fvOZJbGpM+NaVn2UR0aif6nzsa2HzzSMd+cnS3P+0AY3qqQCXwIx2nfp+Cjy3/ni762lQtG9WNXBr+G00BJcWvd0jh2aN43AQBZ7SAm87/PkdW2QXUeyMBBTI3kSQSniemup3gGqmQfisli2w57/cAgs8zm1HpYBq9ejXSQZaUOEeXXPJdmbsZK5P1SYUCzegKOQsz17AI9u4iqLAu2MBG4AApN7tNkthvkj89CcmfIjlyzvlz/HYWrBvaZiSZzV4FdClsEpui3BcXdXjOpJXiRkUvSMrGH1slQTSWeDGgFeKeSXCZoR5PA+k0ehq79L/3GFVuZxesIGBGJx2jtYvajXWCeJ9t65tJb6feQu5IctQrtmIMFk25lVnN1j2oHgGUwdWau9LW9MCtOaTGcrSEdwGM+nApbX0pIQ6n0InGzuUq2zEulLNc/ECA+YJdS84bimXnzRhMGbtMJWOhNVr3aLzTlqhhw9l0sxS3zjHzOaP8OF9cJUqo+eAly67nO9B9fyKu71nPxQ8H8zIxREURAGTSJW0abk2162vLAs+KgX4aC4n98cC8qaI9raBK1fuRhgDzg0NX5nc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(16576012)(54906003)(31696002)(70586007)(110136005)(8936002)(53546011)(5660300002)(8676002)(36756003)(4326008)(316002)(26005)(82310400005)(47076005)(41300700001)(70206006)(16526019)(83380400001)(336012)(186003)(40460700003)(2616005)(426003)(478600001)(36860700001)(86362001)(2906002)(7636003)(356005)(31686004)(82740400003)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 22:57:02.9562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6984869c-c414-4ca9-1245-08dadfb8d8d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/22 14:27, Andrew Morton wrote:
> On Tue, 13 Dec 2022 13:20:53 -0800 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> 
>> folio_set_compound_order() is moved to an mm-internal location so external
>> folio users cannot misuse this function. Change the name of the function
>> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
>> handle the case if a non-large folio is passed and add clarifying comments
>> to the function.
>>
> 
> This differs from the version I previously merged:
> 
> --- a/mm/internal.h~mm-move-folio_set_compound_order-to-mm-internalh-update
> +++ a/mm/internal.h
> @@ -384,8 +384,10 @@ int split_free_page(struct page *free_pa
>    */
>   static inline void folio_set_order(struct folio *folio, unsigned int order)
>   {
> -	if (WARN_ON_ONCE(!folio_test_large(folio)))
> +	if (!folio_test_large(folio)) {
> +		WARN_ON_ONCE(order);
>   		return;
> +	}

I think that's out of date?

We eventually settled on the version that is (as of this a few minutes
ago) already in mm-unstable (commit fdea060a130d: "mm: move
folio_set_compound_order() to mm/internal.h"), which has it like this:

        if (WARN_ON_ONCE(!folio_test_large(folio)))
                return;

>   
>   	folio->_folio_order = order;
>   #ifdef CONFIG_64BIT
> 
> Makes sense.  But wouldn't
> 
> 	if (WARN_ON_ONCE(order && !folio_test_large(folio)))
> 
> be clearer?

That's a little narrower of a check. But maybe that's desirable. Could
someone (Mike, Muchun, Sidhartha) comment on which behavior is
preferable, please? I think I'm a little dizzy at this point. :)


thanks,
-- 
John Hubbard
NVIDIA
