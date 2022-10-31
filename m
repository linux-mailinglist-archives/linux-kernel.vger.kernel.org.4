Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EFC613CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiJaRyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiJaRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:54:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DCDB6C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbpXHQAaFUB380egb4ZG1nTPYmE0HNLRFl6FnKUHHqSmvSKibPcd1vdoxEpM+yrqK2YhRl4iAQ/A6qSTvOQhv0VPfz72dpDJ6X6vEPN0P/5Qo3eF1tRNuH3tGc30iKy0EhYbJWaSwUtAy95RSFCWyStzNnihATdQqD9LjMEEp1fKbfWa15JEOsfiIPMJXdw6sLZS3EAoxdQP8MQ1sQy7zjgeLFDJIAXrbBXMRxp4b95yNfihK/C/FJrQ/k5eX9ZbjfkRf+gUk0LcS7NrZIHCCOR92fIKgEjVRgXSEgKDRiY3oDwTPFc6DkXrzNMULBBJSradjNN1KswjSFqUrtM52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0wnoO64/snEdNnIncQph4IC8CnbesFFR5E5Gobq4ic=;
 b=NURKh9JIVG9xiOlT0GJvdmOBzbHlO1+/uQ8sbsxnIt9p8h3nrHs0kwWkGRAAfwTLaIYteWqLn1WpHghwaTfxtqbuvULtIfhwPMM53TDRdOXHHjrt5SI/ktDLAIXKCz+oglwWopBtEE6iGdrrJQkwIDvxoa6ela9oSjt0sWb+KyRlyCkRDEzehsq44b0l5PtVWVXIFaNexALrMEyIXFh7NNZIcR0di2RPJ1xjwcSWytiT9iIZ1g85vf81aueQNHI61zNHVGXEsQclVr5sF6wR3Zr6b9Pcma1GpEi0mrMmo3h2YHUFc+heQJNTuhqo9wsLzV9eH+WXjuKgEXHyS5d4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0wnoO64/snEdNnIncQph4IC8CnbesFFR5E5Gobq4ic=;
 b=TaYogT6QRIelWqnIsQBR5UHDvvlvHhHvrlgPEymTdcBOAWg9fmA6nj99FHV42o6Dtck0v9ehePnt4igBXAIQuGa4RawIOsgoYgTMAmqzkrGn/2aTUBboNL0wleOM1q2C1V8m2LaBspsjkCBgIXlOdJ0uPNTheokqnHpF2vYz8zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 17:53:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 17:53:57 +0000
Message-ID: <425617d8-3d36-f50e-e582-826a4c6da32d@amd.com>
Date:   Mon, 31 Oct 2022 13:53:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [BUG] AMDKFD: criu_checkpoint() error path treats userspace
 pointer as kernel pointer
Content-Language: en-US
To:     Jann Horn <jannh@google.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Cc:     David Yat Sin <david.yatsin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CAG48ez3a_35R48khgW8D1MxokEqmYP3mBsUwhMq5Vfi5BiyYCQ@mail.gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CAG48ez3a_35R48khgW8D1MxokEqmYP3mBsUwhMq5Vfi5BiyYCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0291.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: f87b77ba-abc1-4701-178c-08dabb68e273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t581lUSFNUDzk4cEMetnh/uAwM9dgayt7AChcvWngBzz83gjuBivMEUcF9flXZf/pqn2IuAwveH5IzQzIns2v/giVJd/Ky2nciGvlmPIFDdd6fWXbmITGu3n2XATwdiMIae21R4K4MlDentSN3nxxP6f5NfoOAhERX5YS3jde6JElwUqTix5x70STq0i/F9J2cwHOXhLqz8kPFTifePIWAcvDhFXknm1CMub3PomsCGHHe1C8zngIJ0dMKr5izbDdlb7b45nf6Afzzg1IiY334rFlLEHvscaUsudqwvAIOxIJuEE0v+un9Wuy0epp+BUDTFnMnsYNV6oNkQ277RtEZiELwvCF9JGbcvLP7gTJ6L6LL7Mt+ErCH9zao0mOc0zPUhuW+GSb26zlhN5PmH/7cGCy9R3jXMdl27QoHPwpESiuQE9eS25AP7ArvUvNVGs2bQH4l27L+4DW5r/yHZZtMu5TsVNnLRen362kAdRkPGmQsEjaHVSGX4fYo7Gibmq1uj/pLmnfln91BOTtodrHxewnIjJNA9qwYOsm1HmDca1z49SFsAedDI2Wo11Q13gG3LxnqJ3ucKMC5G/IxgaHWqZhHGFrB6zH6AhhONnDj5Q+/azYkw7NbQ1pd9cJN0Fv//e5DvRB8lNhoxzBvzum7C7nkC7C6/xWW1jtUwHUFB+Flu+bcKLlh2pSrnKYYYfInspQ3oi6EkKOih74uOgij0WFz4RKsXo42EcBx0ae0o1qnkiGLwpLH6DKJe67M8RPSRdaxLFUjmDxwawlIVAe2Co2ucaiXYt69peWvOgXDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(478600001)(5660300002)(2616005)(44832011)(186003)(6486002)(31686004)(316002)(110136005)(8676002)(83380400001)(6506007)(4326008)(66556008)(66476007)(66946007)(54906003)(36756003)(6636002)(31696002)(8936002)(86362001)(4001150100001)(2906002)(6512007)(26005)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZkRzdqMWUxTzZLbENnczJocnQ2OE9sdExLaEJOWEkzZEI0SVRwMlF5QmZ5?=
 =?utf-8?B?S05VY2dzdUdJcjdKR3VGdmZBK1VucURCS21ZUHJDQ2dqL3lWTTIzMU5FQXhn?=
 =?utf-8?B?cVAvZ2tnREN6T1A2T1FuTHp2WG1nMkU4bFdybmpOWm9MWXJVR2ZnNTNxNnI1?=
 =?utf-8?B?eXdpUXlBMnZIUTNzV04rRHNsbWQxakJaTDdrUzc3bTN1Zk5ycExkUWNteGNZ?=
 =?utf-8?B?SjlMQjZkVTJ0NEV6K0EydjAvOVgvdDc3Y01XQ3VJaXdwVkt5QndkaVRBQjhY?=
 =?utf-8?B?ODBpVGpQVit2UDdSaXFJUU1mS05wc2dhWDl4R296NmdzejAxVGNTV212SHVk?=
 =?utf-8?B?enRwYWRWaW5wZERHcEtad09ibUtUemdlRXNxM014dmNGbkc3Y3BBUitOa05t?=
 =?utf-8?B?VjB0TmxqZ2NHR28rYVpvb012WUIxSG9qOUNWTG1rQ2F0U1F4OWNvUWdWeGxS?=
 =?utf-8?B?NytrNVFFc2RTUHhIb2ZtUHhMVjhkVHFlTDJ1Yi96OXNycXliQ29pWnp1UzMv?=
 =?utf-8?B?cUhIUlMzNVFFQ3IyeXlhQ3gzeXFocEJoUDIzNlpxcFpuLzMrRiswQUt6RUlN?=
 =?utf-8?B?UEpZV3prcEh1T2NyQThITllwbWpTYmFvTHFYNG9RNE8yOHNxUmdSYU82TVIy?=
 =?utf-8?B?WWh3Zm9vaW9kNFpKcm1IUmk0MEFvZy9vNmxaUURHYVNMZUUycUtsM1d0Rm93?=
 =?utf-8?B?TmR3dWJPNi93Y0tnVEd3amtYSS9tVDBDdmFVMkpMR0ZLM2hHMkpXckppR0Zn?=
 =?utf-8?B?NkZLNjQrYjc2VjViM1Y3T3IyYUFYZXVlUlRYODZDZ0VCMnUwbUZYcGtrVmpa?=
 =?utf-8?B?SG02NkJ0aUNFNGRWT2ZUN3c5UW95MDNrRklJdkpBMFIzY3B1c2xrcnlRODh1?=
 =?utf-8?B?TDJBcmJPWUFHUVMyU2FvaGpUVldJMmNNOURrL3hVcHQvUXphb3ZSK2pma2l3?=
 =?utf-8?B?VTU5Ulk0UnJJbk8vb1E2K0c1cVlwejlzcm1nRkR5YTJBQU1TMUQ2cWxHaHRz?=
 =?utf-8?B?SDRtL09WRmtNUGFYMTJhVHdnNENLbDFFSnc2ZXkwNlBZallUaWJuZy93RVp2?=
 =?utf-8?B?S1N0U3Zha1NvWHFvR3JINGlFaEVGVHBMMW16bWg1aXpvcDdDMmg3S0t1bjJH?=
 =?utf-8?B?ZTliWUlpblc5ditiTmtEQXRoNUpHb1dvMHdnQzJOUEw3V0JqdWNVRXlrUUZV?=
 =?utf-8?B?WFBINmY1OHg1VEl4dHM4b2VkTEk5aXZlWmtHbEh3a3I0UEozZG8zdEJrWk4z?=
 =?utf-8?B?eStXeDBQRnU5cFJVeVpiRFZ1bi9nV2NzaS9LWXBFS2hkMUdFUDcwenV5ejll?=
 =?utf-8?B?NWJycTNUOS9CR3dFdHR4T1owR2ZiNTk3VFZZaFZWQXFOWC8vNHdoUEMwY0cz?=
 =?utf-8?B?V2k1MVQvek4wOWZkbE52d25UMjIyV1lidjRhZnIwenpETExuRTkrdzdYRFRX?=
 =?utf-8?B?Wlp0UFJVTmtpWnR5a29HU1l1NmlPTk83SDJEaDZXUzRvU1ZpNXAydVBSMlRK?=
 =?utf-8?B?ZlFnUE5VWXNPeWxram1XVzdTQ2pEYmVULzhtWFMxbWZFRW1MY3poRXpkaEhN?=
 =?utf-8?B?MWpYSUNxc0NIenRqSFhTS0FzU2lYQW9HWkZCcXJFaUJxMjhtRkdqNGtNeWdz?=
 =?utf-8?B?bDFtSStMRWFLZVduaDJZbGc4SHJrNDd3WWw5TGJvemhmWFZQRzJLUm11NHFU?=
 =?utf-8?B?TjdlK044VzJ0dXdsbkpFM1ljVDlQRjZLaU1jMmxNZ3VlSGo2ck93T3RyVkZK?=
 =?utf-8?B?K3NacUZvREg5dHZRRzdjcG1sQVB6RlQyMDROVURNZGxVejlzb0VXL2NLWGMr?=
 =?utf-8?B?MVNBN1lkZXhLb09qSTRIdy9WbTlza1VUOWVXWFFxZk8vVXpLRXhxbEYxb3dL?=
 =?utf-8?B?VmRLbW9jNFYzR29EY25LQkdKbTc1ZUVST0RxZnhFdHBmRW5rMDk4TzgwMEho?=
 =?utf-8?B?aFN3SUxzQ3l3bVNWdTBiSzhzNTNEV3EyMUlXU1hpSkZ2TDluUmVaWTQ5Q29K?=
 =?utf-8?B?ZkpOWm8rN3EyRlg4Q0ZqSnR0S3QxRjhzQ3NZZDlVVVhENHlwUDFOQTVGTkFw?=
 =?utf-8?B?V3E2WU1hcjdXS3pVNThiKzN0ejRJbHF2Z3l2RWZtTVBzYmlueTdhYnM4Zjlr?=
 =?utf-8?Q?HX/hi9uBEwrHEdA/aN66JtjOJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87b77ba-abc1-4701-178c-08dabb68e273
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 17:53:57.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TqiQJfA4ddbeEvEXodWgnoM5+UpiVShDqjpQlpDU+Tw53KsKKeeJ6Pe/CalCLp3dq+HETrL8VMcwg9PAWIP7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-10-31 um 10:20 schrieb Jann Horn:
> be072b06c73970 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
> added an error path in criu_checkpoint() that (unless I'm completely
> misreading this) treats the userspace-supplied args->bos (which was
> previously used as a userspace pointer when passed to
> criu_checkpoint_bos()) as a kernel pointer:
>
>    ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
>        (uint8_t __user *)args->priv_data, &priv_offset);
>    if (ret)
>      goto exit_unlock;
>    [...]
> close_bo_fds:
>    if (ret) {
>      /* If IOCTL returns err, user assumes all FDs opened in
> criu_dump_bos are closed */
>      uint32_t i;
>      struct kfd_criu_bo_bucket *bo_buckets = (struct kfd_criu_bo_bucket
> *) args->bos;
>
>      for (i = 0; i < num_bos; i++) {
>        if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
>          close_fd(bo_buckets[i].dmabuf_fd);
>      }
>    }
>
> This seems very wrong, and also like it's guaranteed to blow up as
> soon as it runs on a machine with SMAP, which makes me think that this
> codepath was probably never exercised?
>
> (Also note that just changing this to copy_from_user() instead would
> still be wrong, because malicious/bogus userspace could change the FD
> number to the KFD device's FD, and the VFS assumes that an FD can't be
> closed while it's being accessed in a single-threaded process.)

Thank you for catching this, and thank you for the advice. In other 
words, we need to store a copy of the FDs in a kernel mode buffer that 
is not accessibly by usermode, so we can reliably close the correct FDs 
in the error handling code path. Rajneesh and I will fix this ASAP.

Do you think we should also avoid copying the FDs to usermode before 
we're sure that we'll return success? I don't think it would make a big 
difference because user mode could try to guess the FDs and use them 
before we return from the ioctl either way.

Regards,
   Felix


