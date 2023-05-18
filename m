Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516997078C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjEREIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEREIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:08:21 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3DA3C3C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8Kk30ubk9Z2bZix0Tt50ukglq/nbirHz2XEedO7d2w9W95zzbljV5agzs0QcGJUiRkRN3IjOW2/WVdbwb+0/n+2xFYoMWS4OgPur1wnHnglgdt8d9nVlW/ewPpkuts3JILHrH5WhNXqdPlINfxfHUSuGOBKU1FyNCzuif9MdmPNqf4GU9Xh+UsWsSAr5bdmcv7bW7dmY2juNPU6WnO76ZEksxMXArVnoK5d1KTPe3LBkSCt8Q53rFo1kyDsVjoI2mQWuw1ijH6F1JuTlEu9M7WVXN5cWH+SsxVvc0YRB5K88u6Ye29MjT94aMUIhLGrcRMII1wFcX/biaW7T+8jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTqXX/LX5dG2H3CwGF5pbN4MJzveFzg5FArLQ1KjjRM=;
 b=ix4hGS2IntaAYJjKtipYj+jV808+p6gDZmJgCv6+OgmEFe3k+BqAESWaO2myon+Tsnz+fFeo7tmO6En+MmpfvQvQ4MZdUaafKGgJFZERttMN3DojaZ0IlfakivSfxq8Cfw5lpdTSx3QnGvpPiHWt0vPTNDLeio5vHKyX147riKnk2rpua3qxFiDUlVvy4lRx6ppQ3Evj22kUXbm7miwMhe5FkyXOrl+X0Wy58F8v/A7MfDMXO+2KJ42QwkTSsIilo3rvp3l8MmwaTU+xeM9ZxWo/BGbw42NA5C5Fx6LlW529vlZMNJZ5pkC/m8kigIErXar6AqSKYftQ6cjCNB5mTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTqXX/LX5dG2H3CwGF5pbN4MJzveFzg5FArLQ1KjjRM=;
 b=D2DG2oMvqoDZki8+CopDQIb4gz4GMjbxUPMhL6drZEESG9lkfyK4WtnmISOfJvpRi9m5+TbSedH2D/vcfFkogzH41e+YQzGWR1T5V1lv1oghTEALvDAIFBzLIuwoN8qH4Jm2poCoXhPhCQGpu9+9W90X+xJPlw8uKGGbH9RK64I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYCP286MB2302.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:139::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Thu, 18 May 2023 04:08:11 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::91e1:d460:5907:34d6]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::91e1:d460:5907:34d6%7]) with mapi id 15.20.6411.018; Thu, 18 May 2023
 04:08:11 +0000
Date:   Thu, 18 May 2023 12:07:59 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Indan Zupancic <Indan.Zupancic@mep-info.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] UIO: Let uio_pdrv_genirq support cached memory
Message-ID: <ZGWkn89Xr1YAP9K4@Sun>
References: <436ea1f019d26d28ab4fce4ee28f609b@mep-info.com>
 <20220505121518.46054-1-Indan.Zupancic@mep-info.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505121518.46054-1-Indan.Zupancic@mep-info.com>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: BYAPR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::38) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TYCP286MB2302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1c9779-6794-41c0-4cb9-08db57557e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecL0gfDZ8hgiEHfMStC6AZbbV+IjVhPIMhQWQS7iDKP9nd7uj7VwuULROPUqoCk2QuNpQzo8zpS/Sjwt8nBixK1eSV1E1hTNpaOa/tpV8o8/KNhtKH8Ljm7YeuLY/sOOD+B+FHqSBLLlwb2ttsaxrTOZ2jNgPZad5Bu/HcPqheWALepdhlgVb8KSOwRDM7C8dMQjBIOcuyzbuR63mvWL0IOv1HBOqkKQegS/IZTD67nB3ctpXD6nC1PHZM/G5u9yS5DUlQQjN422Tk+Dr/jGrZyi07XooLb+mmAGvgaDWdhHloFudeXSsEoq+ju1cEJzOZ8BHykK0VTHJmUW6IU6wCF8Lmh+StOGPMFRJK4JZUPzJxOKBnwFolrPwhP59s8VMKksF5+hivbGKR3mMNzngzUgm2PoeA8KOgukm6KDs+66t704AiadzFkml2iJtOK1oyY1GDgKzYrnEcIoXXXw4s++Zj4Nn8D5oLA6ygI0aI9Ebzgt6c2gWEu0jvBiOOF/nLVkZZsyAAKiAaZxXLWNgBEXHUhldq4ztEJfBDoUx5GUKxwvISlUnkcYjUXfRhLWjqKkJW8TI8UncJXqMG18jacgeegUlKCdg1rSSJK7Qac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(346002)(39830400003)(366004)(451199021)(41320700001)(8676002)(86362001)(8936002)(5660300002)(66556008)(66476007)(2906002)(6916009)(66946007)(478600001)(38100700002)(33716001)(41300700001)(54906003)(83380400001)(6486002)(786003)(4326008)(316002)(186003)(6666004)(9686003)(6506007)(6512007)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/eocpg3BlQoNvv0kOPzPVIT9+eheNmnuLvyXF772xOaNeoxdD4V/eq+5UmyO?=
 =?us-ascii?Q?cIpe8Z/5V7L2VyFfFV3FBQGH6hd+DEcfPdupl+oTxH5DYzpD0a8ijtXBmCHM?=
 =?us-ascii?Q?lQpxAxbMDciMb7GxMqYiMUduGvcXEr63fB1PZBn/wUc3JL+5GZWCoNX+pvNq?=
 =?us-ascii?Q?H34F7WuiojhD+k9N3seYed/2lvGRLWrbbNqe2MRncXV31qhdBpa0icYNDdSM?=
 =?us-ascii?Q?1DZVK2SkSxTNOyo4Oihyf8lVhatW6HfM2jjYHFCX3RAbP/ZbTuq3C9sDI2ud?=
 =?us-ascii?Q?RmJY9bmEQGWdach1jI9dEpbhtqZlcGK9CM6orUjn/ZCx+XG3DmuClHuOC+4F?=
 =?us-ascii?Q?2l0tP8fpmkGaxkRYOgsz6tg7CtBGtfBtkVB0FgBfV2XROO9V5z/Nu0ITJNIG?=
 =?us-ascii?Q?IQI51NshyxlngpYPX6xV1fX2nevIlX6A6Qnuu7su+OAoZT6f1Is0IXa93caJ?=
 =?us-ascii?Q?KTuFXYrr1Vr4m4x+2Vzw4lQA5PBafbRDbAp32hmXDPDt4cFFeqD3WV83K1+8?=
 =?us-ascii?Q?OkrcK/7mdvK4ZmiDzcihe4ub6tWr0ge/SR9jrbxao49qMZMpvm/ucVA2/Xec?=
 =?us-ascii?Q?OH9kq5jrKXYlA3I7KJcwrvgfG8Ks3bO9H+xXa1m985ZQpr98g0TV9z3fR8HL?=
 =?us-ascii?Q?VjkOZ0NhLWXVFITgp2NZOwYV3Vw3ymZI1JrYopgKjU9yMOhx4WRCpo4FtP/w?=
 =?us-ascii?Q?0z5427ObtBloXiWlHaPTUZiZpgUhoK25X+7OtM1ydOzrFiUYMRpdyOBVxtSS?=
 =?us-ascii?Q?BMR7ANwGaErMtehXC0Y4W4HRke5roRmTV28hlavWPKjXBETMWq+41wTI7DTb?=
 =?us-ascii?Q?Oef7p6Hs6564i0+ztySblwfEz43HK/hfn6eJx39GZPUKueoJ7oa2vukBWZm+?=
 =?us-ascii?Q?3tiQw8tsoXLOexXxmeTNmewSC8zzRXcSe4JtpYNtYP1EarMMhBTrGX7lunu8?=
 =?us-ascii?Q?SsZQ6MmrRbFuo7LU4hYZdDYAD7GlL/g135RDEFRlsuaL6sOC23cJoVZMbDHM?=
 =?us-ascii?Q?kZbpeiNLKMpZFFTrL/fCJFeSPVbdLpVtMx86HfbMJKjT1EI/q5dK9kgyr96c?=
 =?us-ascii?Q?8yVo75b+T9AZJwKiU9JQTJ9unWEiFFJfRnPCr5/v9g7Gb7ffG2FltmkbaN8I?=
 =?us-ascii?Q?v2kHQSkhqu+C90UWOpwED7zEqC3xRhFVFHSGrKQIiJllHBnhUoef/4qyB2Pr?=
 =?us-ascii?Q?w/nz6epACTeinMbiEvN+v/IOi/Kam/a1uRhKArJouFibY33MuCKeQtKgIcl2?=
 =?us-ascii?Q?EAIxIcQv4l72JUprAPm0y6wjjTqMY45RWoZyRfu8Y6CnG3q9I10ZKnHdhX9a?=
 =?us-ascii?Q?DeeRqPR2wWMZiCVzcLEYuoBOTaqwj3kSS5pbyksoBcKajpJYiMzNpwNnlfSv?=
 =?us-ascii?Q?Yuo3RWSHKsEfiE+H41++y+RAGvF91wG8pB2jbqp3/2JYtxbcelOB7hYpwACk?=
 =?us-ascii?Q?v26oWAjkil9Vccf1itlJfOLZPD+8vlUolmLdl0yfc/HhSYL1ELFY2ueOJFFr?=
 =?us-ascii?Q?3ts5h/SAh8iKDWOqGZYTH4CwNvHLl9l90s1CrWgor+9H6SV4JIrhwhtmWrBa?=
 =?us-ascii?Q?SdOQWl/HLRl6h7jIlAtQ0Rj/eTnRXdiD9BGTZ0PO?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1c9779-6794-41c0-4cb9-08db57557e80
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 04:08:11.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8NbCG1/xTaGlWYSJU8RVkCXi6yP3O/vSpjcCfRhp7g29g86MgOTpr3vw+h0dPzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 02:15:19PM +0200, Indan Zupancic wrote:
> If 'cacheable' DT property exists, the memory mapping will be
> done with UIO_MEM_IOVA instead of the default UIO_MEM_PHYS.
> 
> Signed-off-by: Indan Zupancic <Indan.Zupancic@mep-info.com>
> ---
>  Documentation/driver-api/uio-howto.rst | 3 ++-
>  drivers/uio/uio_pdrv_genirq.c          | 8 ++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)

I assume this is fundamentally OK? What else should be done to get this merged?

I plan to add similar functionality for uio_pci_generic,
especially for the RedHat IVSHMEM pcie device where
bar2 is just normal memory and should be marked
as UIO_MEM_IOVA as this has performance implication,
is that acceptable?

Cc'ed uio_pci_generic maintainer here.

> 
> diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
> index 907ffa3b38f5..3cb48fc757d9 100644
> --- a/Documentation/driver-api/uio-howto.rst
> +++ b/Documentation/driver-api/uio-howto.rst
> @@ -413,7 +413,8 @@ probed with the ``"of_id"`` module parameter set to the ``"compatible"``
>  string of the node the driver is supposed to handle. By default, the
>  node's name (without the unit address) is exposed as name for the
>  UIO device in userspace. To set a custom name, a property named
> -``"linux,uio-name"`` may be specified in the DT node.
> +``"linux,uio-name"`` may be specified in the DT node. If a property
> +named ``cacheable`` exists, the memory will be mapped cacheable.
>  
>  Using uio_dmem_genirq for platform devices
>  ------------------------------------------
> diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
> index 63258b6accc4..269784ce0ba3 100644
> --- a/drivers/uio/uio_pdrv_genirq.c
> +++ b/drivers/uio/uio_pdrv_genirq.c
> @@ -115,6 +115,7 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
>  	struct uio_mem *uiomem;
>  	int ret = -EINVAL;
>  	int i;
> +	int memtype = UIO_MEM_PHYS;
>  
>  	if (node) {
>  		const char *name;
> @@ -132,7 +133,10 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
>  		else
>  			uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  						       "%pOFn", node);
> -
> +		if (of_get_property(node, "cacheable", NULL)) {
> +			dev_info(&pdev->dev, "%s cacheable\n", uioinfo->name);
> +			memtype = UIO_MEM_IOVA;
> +		}
>  		uioinfo->version = "devicetree";
>  		/* Multiple IRQs are not supported */
>  	}
> @@ -204,7 +208,7 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
>  			break;
>  		}
>  
> -		uiomem->memtype = UIO_MEM_PHYS;
> +		uiomem->memtype = memtype;
>  		uiomem->addr = r->start & PAGE_MASK;
>  		uiomem->offs = r->start & ~PAGE_MASK;
>  		uiomem->size = (uiomem->offs + resource_size(r)
> -- 
> 2.30.2
> 
> 
