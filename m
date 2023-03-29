Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727F86CF29A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjC2S7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjC2S7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:59:44 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF452D55
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpVkeHNP1RlbC1MsUTvQsUh/ULHUloDcO8DB4nBm1UtYmesU2gxrsAXL1ErU19GKpo68Y9U0YwA39N1Zx9GNCs9aLr1VEXp/O8cNj065TvZOB3ygn47LNGg+2vHrubMBXzj0wbMKo7s3hQrnWXqaYNBxebanYMY4AyrRC6KptVNgknhsE0VQ2Xweh9tm6rjOx97+HQTFSeeL9Kxw56vE9cJinFlrn0Mtx3cwmpP1V1XS4soBrsGqql/M4hcHZ/GOM0jXQA4hYtmv8LAiQhSLS9d92qxl6GSyXm58wfusUuAmn/v6MFaeSEJaPQVoLc0B0G6S2VYiPi3mp7R9SgxQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtalErOA2T04fwxb3gR1x8WH5Zu+1t6ClPHSKkr5I70=;
 b=Jx/KHX13FkX6ltV2E/fPgVygHEP2uVe4SYtnlL0sDqjYykEW1C4NfNVlwglEkilwfREDQ0qt3TIpejEU3qKrOjsNfAxIOMI9sYOBIP5VETkoTxryjysvkXI0R8kgAnae0/aKfKD/Oh0SvvD2jVLW9s4Oqfca66D4lf5vRZ9wdJOntJZg4Y0E5BbIkpg212MDAGQKQIuImEHI3u0NwX+zcdu9zd++29IlwVJVvHJPZvbJ9vbOD7OR8UY4Yqgj2E0shw7ovKmRAgPmL7lG89f3gmu+dDl1Zme0/rD8jZbr+RpG7VWGZQmYClesTl8a6y774Pak1FdR+3AdmYnhXqUY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtalErOA2T04fwxb3gR1x8WH5Zu+1t6ClPHSKkr5I70=;
 b=dkQzTloDVmXazqB3oDLGr5zJZjvOwsKqTrhisUTGCtHzR9Iz82CO8z2VQfC7sEzG3Aig/Js+j1Zpevs62UFikhajvMJLXfUfbM4CRFVNfTCx2Jw3AuHGU35dPrXo8IOzy6LvDXhebKQfwI+S2nTQIpGpTn+zWVn1SVxd2KSPePc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 18:59:37 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%6]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 18:59:37 +0000
Message-ID: <57f41574-7886-3bfc-c992-74d40664f5ba@amd.com>
Date:   Wed, 29 Mar 2023 15:00:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] drm/amd/display: Mark function
 'optc3_wait_drr_doublebuffer_pending_clear' as static
Content-Language: en-US
To:     Caio Novais <caionovais@usp.br>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        "Lee, Alvin" <Alvin.Lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>, Roman Li <roman.li@amd.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Deepak R Varma <drv@mailo.com>
References: <20230329180534.99151-1-caionovais@usp.br>
 <20230329180534.99151-3-caionovais@usp.br>
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230329180534.99151-3-caionovais@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::45) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|CO6PR12MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: 475213e1-ca52-4fe3-a0ad-08db3087bdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/b4AXsgQA8UUL63bQxCHpuc9TMdFN3tPNLuhtoUzDjUUgrDsUalifY6PCR6T6kgflmx98d0LIM2iwWQvpSJ3K7Z5tQe4n9CDR8e0OK71l1sygJ4IkYeMzTX8nYHAO6J1NrIQEVccDC6R9u7WUp1sHFAjacHFzQQrFrgmx6xVGNF6GAADVXwryvFjU0A5s/PtNcPXAwW4nikXd2aeHkRe+0XiA4EAsQEs8fszF6zGcGbTzMGHoamNB6EfWeFLAffV3L5AMk9BUYLDEOlMJAXtuO5lgEzENIrJK9IhuUhagGpZAkuBZ6SD9rJ77XAAUY+rDDH8dS/g14fK94uIqAt4HDceHiA2mKRf2p0A29w2YqGpiz2GDKE9/GymkmqERJudcdgq1VQwHhAuWNrBiawNTj0HDM0YGDEkVljy+3Z1LUZCXt1/4dF9123G2nTmAQ0P4Tb0oxCDjdVYqzVN5NV//6Lhmj+16vV8QboNiVkfBJFl6W1KjeYkV5+ZOuqz/Gr6wE08j0sZ9IPSGVokB/uzTeVSbgvqsa9fPLjO1F1/9j8GYVTRYbQFs22T5r3b+Jl8Srz6ZaeCWbkyV1KwTVfAP0uQhdITfruaSxpPUdIy8DcE6s0PPuqbkqHZgK6k7KZEF2Eq8hD9Km0qBiLd4JFmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(31686004)(83380400001)(6666004)(26005)(53546011)(478600001)(54906003)(316002)(6512007)(6506007)(36756003)(31696002)(8676002)(66476007)(66946007)(66556008)(41300700001)(86362001)(4326008)(2616005)(6486002)(38100700002)(44832011)(8936002)(2906002)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2U2azlscDFPNEFScHhEL01QaERHelljR3g1Vi92bnNaaitrNk42aWI5U21L?=
 =?utf-8?B?eEdpaUxoc3duV3M4TnNPRFNuZVcwdXlPbnVydkV1NmRKVlRUVzhoMHVjb2FI?=
 =?utf-8?B?TnVsY09TT3NKLzk4NUEwOFA5end3SGxZYkVqOU5TQUM4QW14UThySDBLY3Ix?=
 =?utf-8?B?VlNqdEMxNFExa093VlQ5dkNUNW0yenFKeDI3eDJQZHpmMW11UFBIMGhSa3do?=
 =?utf-8?B?ZjdJZFUzNmh6ZDZJYW5GWS92SmVzNVJoRFFyNVBTZ3lROVc1aHJTM0hCZFI3?=
 =?utf-8?B?cDlZUElBZkhCcEVxdTYvSmEweURXQk4zN2h3RkM3SkQwRmJPU0tzNXBrdEhL?=
 =?utf-8?B?NW41MThvYldtdmFJSXUzRXVjeStCeVlBbmdLdlFKM0tNZHZMUUxjYStMdHFl?=
 =?utf-8?B?eUpTT01Ga3BaL0tLS1FEYjJYa3c0Mzg3dUV6Y3Vmdk4vSysrbkNyVXdJU1ZN?=
 =?utf-8?B?L1c0d3VvQkFGYmdPMjhUWmFqSDNmejdXMmlmM2haRlZ0L2I1czF0eTNxYXFi?=
 =?utf-8?B?WWFvV3pmclFhUm1YZUJaL0dxSzJnZFFzcml2UkxMZXB2V0RaM0VrZFMxdk4y?=
 =?utf-8?B?eFNoRXB3WHVrUElaaXVXT1RycVlHTjA4eTZidFJTTVBtL2luRXdzK0JiUVVa?=
 =?utf-8?B?bXNpOTZ4YmJBU3hjT09ZQ3FUTW1YaWhrMXJLQmpVWFF5anJORTlKa1lQVEJp?=
 =?utf-8?B?d1dvWHJvUXBRZWxhTjhPOTBEbHFjUXZRN3RwUXd5VXg1bk1NbmJQdDZISHhs?=
 =?utf-8?B?YjAxbk5Wa1hvWDg4Vnc4WmhVckNrMFZYODNYZkxJbXJrNkszTm5FKzdrUFlr?=
 =?utf-8?B?cklnZ1Y2U1o4VlYwaHNtcWVpVFhtWmg4UnhNMUtBTHJvU0dMT0t3VE9jMG9i?=
 =?utf-8?B?UUd2bTdtTTJzZEI4K0t0bVY5WDFGWDJjUkUrV2lrbFhIbm9sL0hxSWNUV240?=
 =?utf-8?B?SFJLNUZRWCtTdEYzWjFIbWZPNXZmM2JTU3ZqRDQ0S3kzZWRTSXVMTGNxdkVN?=
 =?utf-8?B?eGNWdm5pUFM2N3BKMVlhNjQrNy9ReWdVVkZDUy9mbXF1enVGVW5tTkh6SGJj?=
 =?utf-8?B?UkE0UWJqRzZNV0tQa3RKQnpIQ200d3doWWpqVXhBWmQ1bk9ubDkwcTg5c1ZZ?=
 =?utf-8?B?K3U5ZTg4R2ZHekhNc2VJWDB0UzkyVFJBb1lxTjBSaUFVeXZXTXA4eHpqbFFM?=
 =?utf-8?B?dGczRFZKRm02bXVhMlVUL014Tm5VdWhEcytTWklET0k5aUNRTmJvcWNQU1hV?=
 =?utf-8?B?eFhueUZSRFVKd1REb3dGRWE3OE1LRldhT1kzK2JETU56a3dTVFQ0dEYzY0ZF?=
 =?utf-8?B?S0w0Q2xrWlBmR3BwSW1ZbVk3SDFnT3NyT1hGeVVTak94clZxTVpISDh1anJk?=
 =?utf-8?B?Q1BTUDZMWmhVUksvbFRSbEs5Qk1DOGQ4dWtVTlpCelRzbmtKb3N4dEY1aGYz?=
 =?utf-8?B?cnI1a2xvZ2k0RDZub0p6c0M3ejNId29UWTVLcEh3N1pYWFhsNFBxeVIzM2dH?=
 =?utf-8?B?MXYvZGllTlFMZ0xsdmh0RGxLS2x0ZTdhV0FEWi96Y1NPbXhDVlZvekordzhO?=
 =?utf-8?B?WFNkZ1BaRHFDZ2lWRzhibnhMV2taalVhZUxNM1FlNHhlUVpPNmZmV21CWXpk?=
 =?utf-8?B?QzRyODN3WERhWXZJUzVPSjFpYmtmU0dKaUJLaHBpNjh4a1RVYWZKNFZzemhV?=
 =?utf-8?B?Y1ZyRS9sRmtPbE1JazFLZG13UlpXZGxjcGhDUEc3VGF4T1BPeGVMS2djeG5C?=
 =?utf-8?B?emNnbUdqQ01vZkNWNys1YjRUTmxxdGdNYy9GTzkxRkFyYUpBRks1WDh0b3RH?=
 =?utf-8?B?bTNqNmQ1eE80azlXbmR6L213bUFPYVozRldVMVBITWZiKzM4eTd1OG5lWTBU?=
 =?utf-8?B?elN3ZU5QTk9WRHVQektSSnlMMnRpa0tuK3VOb1craWVNNzJiT1Q3MGZwWThN?=
 =?utf-8?B?aDYxS2xPYlI4bTdzQjMzTk5HOXVEYmRtU1ZjQ0xNVUxWRVpscGdJVEphZkph?=
 =?utf-8?B?QTZrTzhZWGoyUlFwbmQrVjh2SnlGNkZaNHdjb0h5SUNDQzdQeG1PZy91Wk5H?=
 =?utf-8?B?U1RJeXFjU2RYVU1BMHBIREdqOXMzNUJNd0tDUGJZcHpBbmkydlJYYzg3eVM4?=
 =?utf-8?Q?3SyId3BH8nbtPSKdtFKY62lpI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475213e1-ca52-4fe3-a0ad-08db3087bdff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 18:59:37.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf/RpWpRFNl0rcF+Mhe+ipw8Pk2mGegHzqX4/KBXNot9DfaevJCeN8fbxGF/rQOmQJxWo4yQFdque4w/pJ3l5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 14:05, Caio Novais wrote:
> Compiling AMD GPU drivers displays a warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for ‘optc3_wait_drr_doublebuffer_pending_clear’ [-Wmissing-prototypes]
> 
> Get rid of it by marking the function as static
> 
> Signed-off-by: Caio Novais <caionovais@usp.br>

Applied, thanks!

> ---
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> index 08b92715e2e6..c95f000b63b2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> @@ -291,7 +291,7 @@ static void optc3_set_timing_double_buffer(struct timing_generator *optc, bool e
>   		   OTG_DRR_TIMING_DBUF_UPDATE_MODE, mode);
>   }
>   
> -void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
> +static void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
>   {
>   	struct optc *optc1 = DCN10TG_FROM_TG(optc);
>   
-- 
Hamza

