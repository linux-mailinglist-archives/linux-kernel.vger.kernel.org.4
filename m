Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F96F7078
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjEDRJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDRJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:09:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F0E3A9E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7DcCtkFbmXfTztLX1Moy6P6fN9pDI0sCNFu8h1QnngFMzhfxJ588BO02A2cjF3htRsOMpk+c14lbrRF/1r/SK9xuxoSS6ZGX4wSv+TG0rpMyy6up8JjIur6pkqaVcrJOh5xoyE7UgV45R2XZkLo+rmorCxYYRb0TV74X1Qu/93WTbJzgYFA8JZ+6OcXRe7eeD5T6nvq1BW03aNCiBiSIWZZ7Yd8JZ3xU1bE3+3Um2BZGjL+sabwTxdDXrA2K+3O7H4JDw/IrCc6dBGJ5t2z1YTq7T9Dv1pVTPmJIbDiomd/VhB4woQrrvl9pDH/hBJKTyJdeOMg/pKxEtDyO9rfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb59ijZ+Gv3vjr3op6gt85mvgVmrx64vMsmhSrfAKkI=;
 b=AfmfrHcI/z9Fm/6BA0v4PxkKPKOlLqfWJWalAP9Ns2KVVMoY0UC0KOmV0Ea4PxURR9nvcpskCNCzAXZB8GScO6L84ZfEPHeFR/J9sk0lOcWTTxY4U6ZmSifKBl/cNvFggABnd27Ev7T8RAOB4OoGM7cD0RM83suB/90KpHhKeB9MJYC4PcJZ6rF69cjMVoyjbgbwZtu5OymSu2SB6KRsS7geqCSPL3Taipqfr7msw2s0/er6XHQ4EJNkw+uxPp/VRbgS0Riu+e891/koy9OPvZRa+viXuVF83AZJoK6DUhAe8MIIO1klvHUsWpIOBGmLMS3De8uuY791/o31DvrB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb59ijZ+Gv3vjr3op6gt85mvgVmrx64vMsmhSrfAKkI=;
 b=sZSLfnNYOI5X8DGsHgeXa6/6uMimNlzw/CLPD5OXyAfUn6I1I2lBRJeP42qUtJWLTkAb9Td9s5R9ZbPnTIGr0EHXaKfyV2nfbdML8N76/pnoEbDeHi7ebI1gXPr6P6fbdU9JhBJvowGZGB7x4kJk+C29Urlz9cLBDQUl5dNi98xr7j+llml3k1uNYbv5a8GCPJt4LVroyqWADkXHKUH9rU9QDzgJXS9fw5vH4wNwtZPcFb6wVxtjARgI80suBXW0k9JF67S66EJ4D5ZuXCGjGOi6nfdG9mP9wORc/7ApcO1Pz0dEqDu1aEljGLMjcXUuyMBcTH2M0FD/delinphplA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 17:08:59 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6363.020; Thu, 4 May 2023
 17:08:59 +0000
Message-ID: <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
Date:   Thu, 4 May 2023 13:08:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
To:     Dragos Tatulea <dtatulea@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
Cc:     Gal Pressman <gal@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <20230504135053.2283816-1-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1828c278-34ed-4d1e-ebf6-08db4cc24041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KD8smkcrJAmqzkP8jcPoi6jRj2U4JNb3JxcbCA/Y+yhU9y//cZl0MmFdTDVJEZ9oxEspSneTrrG41j1FVjFBfBbKqtxNQbjtNyU+4+d72MgqRrOnsdjBHlkFK2K5huJqbkSIE9JE+o00W3fB+qpRQgnYnb1EyxSMUDfH/8yACWiGDcoLVDtaOqtFvxHWoJ9VRuaWcYnutE2/s/mcLl6eaZm581Qb1Pgxe/CkyjI3bSWEdKAZzTcFA4dbyAuLK0PNVNY1tu7W5OWocFiY+Yr6PP8qXGv807v0RpEdikKWOqv9oCwT3k8lQB5Ex5XklKrT4fJKtrdtr/ZdNs3kcqiWVJh15ehzmFxp0lZvNzooDrHdD20ulKML7/AhXDL9SCoJkzfAizNEB14PgBvanTv1olaRVX/mXovUZ98Xb73MI8ZZw45mOMTuT7utyjb7kCdpOfYf0hTxkDXvlE3Ph8LvgH93bfYPZ/zxvsllPLwcoQWtKT9W5FuA7xzjEBoKfzBaxoUFPidot2XM5M2KLZq+HpalxgkayK1sF8PCL6v/BnSzD4rDd4dGLyP/WzxbRr6iCN9U2oP+czLquPezBmruQwzFKuPXR5nJM4JSzNONt+yXUF6SbZ+T2pZRKs3s9EfMxaydSBd4fQ6vOt2Cx+jLrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(8676002)(36756003)(26005)(6506007)(8936002)(2616005)(6512007)(5660300002)(66476007)(316002)(110136005)(41300700001)(66556008)(66946007)(4326008)(6666004)(6486002)(478600001)(31696002)(38100700002)(86362001)(186003)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1NPbEVHb2U2M0pZNVVjMVZHSTNoYVdBTkR1WXBsZUVicEZrelBsSTByMzc2?=
 =?utf-8?B?aUV5VzYvQnlLbHhNZ0srb0FpL2xuekZ0QmtybHpVbStSZk55d0lpY2ZQeDd3?=
 =?utf-8?B?M21HUVE3dG1rQUxiRUlmQ3FhSUc0VTRhVVRnU25peU1IOG82UWxMdi9NYkxD?=
 =?utf-8?B?UWlLd3Vaa0ttNDBCY3o3QmE0cE1IMytsb0liYXZrckU1bHBwY0ExN1NnazUr?=
 =?utf-8?B?MDVPZkl5WUw3OUVxT1BYSENreWQ4YnFzSzJyTnFWWWY0WWc0azVweFZ4MmJ5?=
 =?utf-8?B?SFRvc2lhdzZkVktCbWhwbXVNSjlhL2w0czRyOWRpaHc0dUZrM1BVdHRZQ3Z5?=
 =?utf-8?B?U1VDSWs0TmxBdHlncDAzdGE2NFVDSkEwZzhLaHlaMm5JdkVPTStmUUFaQ1kr?=
 =?utf-8?B?ZlFjVlVmSlV6dGFRR2N0THdvSUNLL1NqQ2o1TmRLbEZ4VFZWcUdPV0NrTlBI?=
 =?utf-8?B?bTZzUGZjYVdEQnpHcGp2OWlKSHI3M0VHNXIwei9IenR6N3ZZK0t4VW1EaGtO?=
 =?utf-8?B?NXFoK3RPb2t5cjZMVUNBNklYVlpMMUVPNStFeUlNUHBNaXR4WVl6NDk0dmpP?=
 =?utf-8?B?OUhwSEQ3QVNrd2trWmpqTnNnRGl3NlppVUxVNHBqSEdzZmtHMjNLNytnNGFR?=
 =?utf-8?B?SjczUVJBYkpYUG00ZnJXV3IxbXZHcU41MlUzSnJsNHhhM0JPMUVBc0hPRGRi?=
 =?utf-8?B?OHFCRUgydWgzZDdqMm5wRDA5ZnhONmRjL2ZMSzhmemZwb0dQaWtoMnBxNzhi?=
 =?utf-8?B?N2N0cXVHcjBVb3hQUWswUDN2OWJKNlFGdUl1cWVGZFdqQXdaa3hyeFcxMVdH?=
 =?utf-8?B?enovZUV6RDNuZVdnTVNsZVhTTmgvMzF1bGpHNkRDUWx3YjQzTGJ2QjFYazk3?=
 =?utf-8?B?NmxWNFgvejJncWlXa1d4QXdDRHkrd1o2bXk3VThZNENYU2piYzB5RnFvYm1I?=
 =?utf-8?B?Rkt0blpCYi9wWjRLR3UxdUpyTjhPdjV0b25lSU5SQWdMSzNrVE1tb3hsV1gr?=
 =?utf-8?B?UUZQTTgxd3JheEFReWUzYStoaXoyenNRYmd0Q2lXeTVYUkl3K1owaytiWmJz?=
 =?utf-8?B?V0NqNmRpSXc0ZE9sR1FJSWlybkUvbW4zSngrbUd0d2lNL3dHRVFyb0NST2t5?=
 =?utf-8?B?M1lHLzlFbDFNUDJZNnFHRXo0L21XWFJhbkZpaTVqeTR0MXc0OG5jWUtieitU?=
 =?utf-8?B?elpKM0JYWmcyVGJKekIzZE0xdFEzZkw0TVFISTlpQ0dueURRRS9LcC9XQUlZ?=
 =?utf-8?B?RjQ4OU5UaGR0MDNrUHdGRTNCSWx0R1c0eXg0eFdrNGJOUmlyTzhHRDRLeGIy?=
 =?utf-8?B?bjRlQ1lKYTY4WCtUTHJMSzRtSy94aGk4TXNad0xjSGdLYndXaUJpeVdCWFp2?=
 =?utf-8?B?RHloeXJNd2FBbmZRc3NYWkdJMGtwZ0EwMU1DNXBJSE9tc1ZMRDJDeHhVaEtC?=
 =?utf-8?B?bXFUSzVFS21vL3lsSTgxN0tsbkRpRnJQMjZldm5ycmVRcHNJSDRlbE11aUFi?=
 =?utf-8?B?WFczaS9kaDdheDZ0S1RhWVJBSlR5RW5ZdkV5czdWak9tOHp3aE5Lc2g1dmdx?=
 =?utf-8?B?dGdEa0VQbmhBMXVpczR0MGxwaUxiMzZ0WTR4Z3JEWkU0TWJOU3NUSGgxbHEz?=
 =?utf-8?B?Z3gwS2FUU3hXK3FrUGVrWnJSNXNyVU9OWFNqQUk4dUc2MXJUem52emV2WkhP?=
 =?utf-8?B?ajJjK1VHSkVOTXpnNUEraU5sbXRpbXhMRVNnT29IaStDWjFVcGNncitGYTZj?=
 =?utf-8?B?ZFJ2UmZ3YzJHeXMxSC93YzZ6cUxsNmxLUzUzTFphOXNtRHV6OGozeGhZSlQy?=
 =?utf-8?B?TEpsTHhkVzVldjAwS2pTN051ZDM0OHdRYnJsOEM3WVpmbmRTaTkxQkFQQVo0?=
 =?utf-8?B?a1hkVDVLRkcrVklweXQ2cGZNWHhvR0tHWVdkU3l2cXdmazFJZG8vdXlMUUJE?=
 =?utf-8?B?RTJvOC9jQ2htb09paDVoUVlFRWxOUmh0M0N3OFdhaHBrSGx3OVRDcmcrL1dm?=
 =?utf-8?B?ZkY2aWNvcHNYUEdya2tnRDFrT29SbnlqekR0YUpPZW9qdnowTjFMVFVGWDB5?=
 =?utf-8?B?MWtkSHFLajkvVjYxbEMyQ0hVdk9WRForZGd3dzF2UjlaVEwwSW5qREEwc1Fm?=
 =?utf-8?Q?0ZmvqUJ/i+ImUFYu8v/Ch8pvX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1828c278-34ed-4d1e-ebf6-08db4cc24041
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 17:08:58.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIsvKfZtLIwnLZ9n8sW4vG+iRhW9hXhMxhdAUOfDev8SXjEfk71a0Wp2n/gVXEfKcYRGgUG1/hJlbzpM8xJ3Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
> External email: Use caution opening links or attachments
> 
> 
> The referenced patch calls set_vq_affinity without checking if the op is
> valid. This patch adds the check.
> 
> Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>   drivers/virtio/virtio_vdpa.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index eb6aee8c06b2..989e2d7184ce 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                          err = PTR_ERR(vqs[i]);
>                          goto err_setup_vq;
>                  }
> -               ops->set_vq_affinity(vdpa, i, &masks[i]);
> +
> +               if (ops->set_vq_affinity)
> +                       ops->set_vq_affinity(vdpa, i, &masks[i]);
if ops->set_vq_affinity is NULL, should give an error code to err, and 
return err

>          }
> 
>          cb.callback = virtio_vdpa_config_cb;
> --
> 2.40.1
> 
