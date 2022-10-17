Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A33A60186B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiJQUAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJQUAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:00:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B13C174;
        Mon, 17 Oct 2022 13:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGG5Od2fT7PmmRZraoRKUepHrzEqd3AltTwpu4LCU9cJKb1NlsgXkOHbLjRlk1QleRyW/kY2yCygzAVObruMmNi0qxXdMkPjEw/tf1TgsT0g1sBuGQMLmW78ZjaHWuQXuBtqP58ZEq+1nsfJzQt71LfziAZR8LiRn48eRPhP7KO98XqtC83RLtOOTKC8gKc/9mNCtW6j1NfwnxOFr1bScQE9G5tSz9hNzr+uOJQ6RrhOeWz4qmXLoIBpr0vXPqvkzJe1YH50HgPHBiW2qK+8GZmSTN+Nf5cjtRg0BglMGpJDDpQNoixsM7T2wc6XyFiOv7URTjnwScQ3tsZY8Waj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PQlbMBcopB+Qt8GA7nfG5QNctYXIRvKY+5yGIJZlYw=;
 b=FJ7NYMMefbl5Np5MzwFIBgxxrXQhynnFE1FNdVZ0O8bBcq3uB3Wyie6Xgjw/zyd8dENz83TjnxL1anmpRMKjYVz0Vc9WdTQGOm2YrWmTMKFbPU38S6nI3ZOcvQokO0+71rkVnLJKQOx+qrOsww2THOafAv/SF2vUV0qI3j+Xjur/H8ylSnxLmG8vMN8X7n3YEfMILyMNduG1pNjjny02IHk4Uj3uNhCIEaaf0DgNEdNIY3VSxpa7uhv68UVZ8ndeFCR09asWxRBrK5st9HcbwnCr9Gd39+OHi+ILPa4kRh/+kY90YUvC2yMjOmrPYA4XNL6RiJlX7g2vWCi4b9XkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PQlbMBcopB+Qt8GA7nfG5QNctYXIRvKY+5yGIJZlYw=;
 b=J4WfJ4egu89uOvQX67eiOuJID0du1MbDP4zb3T2TYrl31pBWuKuDd+9yFSKsu4q28vF3nfr/2L5jbzjqqHQGvsCwtvpkxQ5fHZXalFVshGTFPWUOe+TX/rL9hPJ2JKOLm7n5wdb/JsgXY8tRP6JJO5Lw4HUHQc921nj26lgEvoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AS8PR04MB7847.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 20:00:00 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::306c:ec79:32a4:afab]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::306c:ec79:32a4:afab%9]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 20:00:00 +0000
Date:   Mon, 17 Oct 2022 14:59:52 -0500
From:   "han.xu" <han.xu@nxp.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?utf-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mtd: core: introduce of support for dynamic
 partitions
Message-ID: <20221017195820.ve6c3zj2civkswm6@umbrella>
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
 <20220606151417.19227-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606151417.19227-4-ansuelsmth@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AS8PR04MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ea957d-a720-40d1-29d4-08dab07a2bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K53AcWz77WKYQunr4/GSIEGYcUaCw48G5JtnmhTkfvY+kUDGtfm3FSeqZPOUdv5qogBibPAzmEyFV9z69/f61zla8gDhpEoUqXlUSpzM/sl+8/fDy4upXYGvl8axcJOwMekOQ+pllc3nUZpSnn3QJfeewoSlcnTJBsidiPdzGVbyI3VuvOz3qv5IVqRYqNHrCGfJECcjh6oM83TN9mzWAr0pHNC1beoqLAHt+8UWJEGIU9aues63AWuYim7Laa7dk3yapAoKVwSP7gXHtfnloBvcAQiHJJG6WiKOt6e4KLumN/DlDNm4Im2ld5xzkRrenrPDySor0zv6qmdJoCeIA9AYsPhu67C5m7GO51FU6N26rVv9hTwaAd+3N0GsIjwmd40bkW3dTS2MfzErhqiFjLEBhD11W1BZ9tBjRbZE2115XQ39k8sgOjM15YT+boSpbvMvf5+1tsosBv+clPPiVwWjF1jVdX/r8Vv0rHQJ3Y216SG89UDASxoznfJxYOGa0JNvaQx3MuZVz+Zf+YNg5tzFhiWs5LoIyrEWLWyyfiCMliwINrf25ZUSzgNiuie8k0UZtAppWigw0ixsleqZbqCjJ6DmkHzBzASg17CUlObHJ8BBFIj5ZXKgKmOTqKKtfkqb2MeHnU2blzlvgybq/ls8yZAPYycql3ITeV5ySwDYwTqJ6Ecqt87y9kx9UxV3qNGKGiAdCRKQ+BUJDTM3nf6liQagQ1giW4Y/cwQQj0rR8xS5RFv6bspVRmGmx/31zfTw34hzrZOygguHqOLGGmWoCxws4t5z808k0G3ereI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(33716001)(86362001)(38100700002)(83380400001)(6666004)(38350700002)(66946007)(66476007)(316002)(6916009)(54906003)(8676002)(7416002)(66556008)(5660300002)(966005)(6486002)(2906002)(186003)(1076003)(8936002)(6506007)(45080400002)(4326008)(478600001)(9686003)(26005)(41300700001)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7yMvYP+4kbow2eLctgxpK2DuLS64fN6ZpnRNXcenZYnCIldDYZD2uULcpU8s?=
 =?us-ascii?Q?us3ZGb5uRZxzOkz2dkPh/0E3slW/LfZ6CHjhQy+gcqvTh48Os56HFcFXS1Cs?=
 =?us-ascii?Q?F7J6pKKhU7vxodCLYcnBlw+X/GYt9saCKMJm4t0e1IY9aETQ4eU5lv6ikpC1?=
 =?us-ascii?Q?XnN9ZRNhoLg7D5Jn91kByRuIeKz/Aab5qVDNO5prUPKWXDOqVLS4VqvEjryg?=
 =?us-ascii?Q?iCK8kIm13AjkpFQ5VDVBlQg4H32w4Lid3pAjjbUcBVZnmRu16KgIADDbgTJF?=
 =?us-ascii?Q?kIBxZnAcQScZZ7DRnsXRamHoxuhbw/C/xqPp7c1eQhjoAETcZlJj885hs35M?=
 =?us-ascii?Q?V0nAsF3OV3nI9jRVHQixm17FnksflZ1aY5TQi3KRMiSBMhW1ZxJHaCvLLKcI?=
 =?us-ascii?Q?GSa+eA/LTO7HbxzZjaAHGTj6bjMk35JQRo2FrDh0Axeg9yNk5o2ftkI3DQpC?=
 =?us-ascii?Q?yrBB+B/qZjr8XNAcUU6C1RgHERU3S34kLJq8MjAc6xeeT0BSlv34i+yrCm3h?=
 =?us-ascii?Q?tQj6p8dEFeqlBKelaSs9Eo6riZKfSRq787z/HCBJhb+Oe6S40YOzAtQCnQQ6?=
 =?us-ascii?Q?iMzIlFbP3jNdmoAQw63/mwJGevYwdtwuxqU9LXP7+kwu/NaHQISkFMhRCgXV?=
 =?us-ascii?Q?4+mjIuBNlbaWg+kXgHR6KZobXu3MPFAWKzhmDGGIveMz3nD+KBCJHx/lbYmE?=
 =?us-ascii?Q?HvXaxOUu+kLr81F062UJvpSU2knhjCOMziUw6hY7RkKD/vl5bh0NMTevQvKH?=
 =?us-ascii?Q?9it+oKTA+sVBW3GzhcUXAxMrhfNXayzRnvi3yOjMyKhPyBYItH4b/c5eYiHn?=
 =?us-ascii?Q?uFwRIu0dIOx2aiECE2mfwYKxsKEGagm9FQOfsLTWzHqxYf/vE6jaV8xC84Z/?=
 =?us-ascii?Q?Qq/+H/ImKZhcjkbmQyc6AaHbn7ERYE68qEf8Dgudp45qMwHGb/xvQZ47mUKl?=
 =?us-ascii?Q?+ja2rcO0qMmvBx9kbbbcDXLFbEz1mbgYZJEOxmNDXyGvKs/Bx+kNOLDi4p+v?=
 =?us-ascii?Q?CCA6N4zfJ0axmln7HwxpkgBc6IHse9RAjPpOUKV8t5apsnCV0drhpC4m6KjJ?=
 =?us-ascii?Q?ealbjTLNidlO+JeQ7UVCm6lL9juKISQ+y3ES787aJol3LAJD8MH6LpaBZRh0?=
 =?us-ascii?Q?Nesu3Ldbsk7ahpN+QwrGyF/hSeSjkWq9IUs4nTscrb0/6bQFnli9mHcYrJvz?=
 =?us-ascii?Q?EhH8yt+LxmexSAKNYEBD+68S0Rrbh3UltXzPxuC6aD7k0z8giUR6aNjsVgcH?=
 =?us-ascii?Q?nXKBAyh9Gld2iZgu5GeJxZa5bXQGD6RsTGkQ3VLJ6Nxoo3Ih7foWN336TJ9R?=
 =?us-ascii?Q?8k1AOpTwC7Xjg/e8oHv4wDqBCBN0qU2O1B6DOexrKLajgLqg1DzGpyUYkmqk?=
 =?us-ascii?Q?hERT3MnNQVY+18s2bs8anxO+ioamIjRbhOR/zQX91wMHRtm3Ujn4yokJ17Ss?=
 =?us-ascii?Q?m7WGjjiLu275kZKRdcBZJe4RhYZbvJD4nsLetpqccTDWjsfkH3u/Iy+QBPc0?=
 =?us-ascii?Q?l5oQKTHpQnCrwBqFWmVpR9QKCe+DVHmjPIcGDIpf2B/+01Ypm/+vw31C4Gla?=
 =?us-ascii?Q?03jZkmsViECB4hwN9K0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ea957d-a720-40d1-29d4-08dab07a2bbe
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:00:00.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0XC6fMwjw4BnHsTeSnLjcnhJ8VGxzz4MH3jYp3+va4rb7CSq3+OnwpX236wKcGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7847
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/06 05:14PM, Ansuel Smith wrote:
> We have many parser that register mtd partitions at runtime. One example
> is the cmdlinepart or the smem-part parser where the compatible is defined
> in the dts and the partitions gets detected and registered by the
> parser. This is problematic for the NVMEM subsystem that requires an OF node
> to detect NVMEM cells.
> 
> To fix this problem, introduce an additional logic that will try to
> assign an OF node to the MTD if declared.
> 
> On MTD addition, it will be checked if the MTD has an OF node and if
> not declared will check if a partition with the same label is
> declared in DTS. If an exact match is found, the partition dynamically
> allocated by the parser will have a connected OF node.
> 
> The NVMEM subsystem will detect the OF node and register any NVMEM cells
> declared statically in the DTS.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/mtdcore.c | 49 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 7731796024e0..807194efb580 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -546,6 +546,54 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>  	return 0;
>  }
>  
> +static void mtd_check_of_node(struct mtd_info *mtd)
> +{
> +	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
> +	struct mtd_info *parent;
> +	const char *mtd_name;
> +	bool found = false;
> +	int plen;
> +
> +	/* Check if MTD already has a device node */
> +	if (dev_of_node(&mtd->dev))
> +		return;
> +
> +	/* Check if a partitions node exist */
> +	parent = mtd->parent;
> +	parent_dn = dev_of_node(&parent->dev);
> +	if (!parent_dn)
> +		return;
> +
> +	partitions = of_get_child_by_name(parent_dn, "partitions");
> +	if (!partitions)
> +		goto exit_parent;
> +
> +	/* Search if a partition is defined with the same name */
> +	for_each_child_of_node(partitions, mtd_dn) {
> +		/* Skip partition with no label */
> +		mtd_name = of_get_property(mtd_dn, "label", &plen);
> +		if (!mtd_name)
> +			continue;
> +
> +		if (!strncmp(mtd->name, mtd_name, plen)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		goto exit_partitions;
> +
> +	/* Set of_node only for nvmem */
> +	if (of_device_is_compatible(mtd_dn, "nvmem-cells"))
> +		mtd_set_of_node(mtd, mtd_dn);
> +
> +exit_partitions:
> +	of_node_put(partitions);
> +exit_parent:
> +	of_node_put(parent_dn);
> +}
> +
>  /**
>   *	add_mtd_device - register an MTD device
>   *	@mtd: pointer to new MTD device info structure
> @@ -651,6 +699,7 @@ int add_mtd_device(struct mtd_info *mtd)
>  	mtd->dev.devt = MTD_DEVT(i);
>  	dev_set_name(&mtd->dev, "mtd%d", i);
>  	dev_set_drvdata(&mtd->dev, mtd);
> +	mtd_check_of_node(mtd);
>  	of_node_get(mtd_get_of_node(mtd));
>  	error = device_register(&mtd->dev);
>  	if (error)

NXP GPMI NAND controller with 6 cmdline partitions meets refcount underflow
with this patch. The of_node_put(parent_dn) doesn't work with cmdline parser and
causes the issue.

[    1.078910] 6 cmdlinepart partitions found on MTD device gpmi-nand
[    1.085116] Creating 6 MTD partitions on "gpmi-nand":
[    1.090181] 0x000000000000-0x000008000000 : "nandboot"
[    1.096952] 0x000008000000-0x000009000000 : "nandfit"
[    1.103547] 0x000009000000-0x00000b000000 : "nandkernel"
[    1.110317] 0x00000b000000-0x00000c000000 : "nanddtb"
[    1.115525] ------------[ cut here ]------------
[    1.120141] refcount_t: addition on 0; use-after-free.
[    1.125328] WARNING: CPU: 0 PID: 1 at lib/refcount.c:25 refcount_warn_saturate+0xdc/0x148
[    1.133528] Modules linked in:
[    1.136589] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc7-next-20220930-04543-g8cf3f7
[    1.146342] Hardware name: Freescale i.MX8DXL DDR3L EVK (DT)
[    1.151999] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.158965] pc : refcount_warn_saturate+0xdc/0x148
[    1.163760] lr : refcount_warn_saturate+0xdc/0x148
[    1.168556] sp : ffff800009ddb080
[    1.171866] x29: ffff800009ddb080 x28: ffff800009ddb35a x27: 0000000000000002
[    1.179015] x26: ffff8000098b06ad x25: ffffffffffffffff x24: ffff0a00ffffff05
[    1.186165] x23: ffff00001fdf6470 x22: ffff800009ddb367 x21: 0000000000000000
[    1.193314] x20: ffff00001fdfebe8 x19: ffff00001fdfec50 x18: ffffffffffffffff
[    1.200464] x17: 0000000000000000 x16: 0000000000000118 x15: 0000000000000004
[    1.207614] x14: 0000000000000fff x13: ffff800009bca248 x12: 0000000000000003
[    1.214764] x11: 00000000ffffefff x10: c0000000ffffefff x9 : 4762cb2ccb52de00
[    1.221914] x8 : 4762cb2ccb52de00 x7 : 205d313431303231 x6 : 312e31202020205b
[    1.229063] x5 : ffff800009d55c1f x4 : 0000000000000001 x3 : 0000000000000000
[    1.236213] x2 : 0000000000000000 x1 : ffff800009954be6 x0 : 000000000000002a
[    1.243365] Call trace:
[    1.245806]  refcount_warn_saturate+0xdc/0x148
[    1.250253]  kobject_get+0x98/0x9c
[    1.253658]  of_node_get+0x20/0x34
[    1.257072]  of_fwnode_get+0x3c/0x54
[    1.260652]  fwnode_get_nth_parent+0xd8/0xf4
[    1.264926]  fwnode_full_name_string+0x3c/0xb4
[    1.269373]  device_node_string+0x498/0x5b4
[    1.273561]  pointer+0x41c/0x5d0
[    1.276793]  vsnprintf+0x4d8/0x694
[    1.280198]  vprintk_store+0x164/0x528
[    1.283951]  vprintk_emit+0x98/0x164
[    1.287530]  vprintk_default+0x44/0x6c
[    1.291284]  vprintk+0xf0/0x134
[    1.294428]  _printk+0x54/0x7c
[    1.297486]  of_node_release+0xe8/0x128
[    1.301326]  kobject_put+0x98/0xfc
[    1.304732]  of_node_put+0x1c/0x28
[    1.308137]  add_mtd_device+0x484/0x6d4
[    1.311977]  add_mtd_partitions+0xf0/0x1d0
[    1.316078]  parse_mtd_partitions+0x45c/0x518
[    1.320439]  mtd_device_parse_register+0xb0/0x274
[    1.325147]  gpmi_nand_probe+0x51c/0x650
[    1.329074]  platform_probe+0xa8/0xd0
[    1.332740]  really_probe+0x130/0x334
[    1.336406]  __driver_probe_device+0xb4/0xe0
[    1.340681]  driver_probe_device+0x3c/0x1f8
[    1.344869]  __driver_attach+0xdc/0x1a4
[    1.348708]  bus_for_each_dev+0x80/0xcc
[    1.352548]  driver_attach+0x24/0x30
[    1.356127]  bus_add_driver+0x108/0x1f4
[    1.359967]  driver_register+0x78/0x114
[    1.363807]  __platform_driver_register+0x24/0x30
[    1.368515]  gpmi_nand_driver_init+0x1c/0x28
[    1.372798]  do_one_initcall+0xbc/0x238
[    1.376638]  do_initcall_level+0x94/0xb4
[    1.380565]  do_initcalls+0x54/0x94
[    1.384058]  do_basic_setup+0x1c/0x28
[    1.387724]  kernel_init_freeable+0x110/0x188
[    1.392084]  kernel_init+0x20/0x1a0
[    1.395578]  ret_from_fork+0x10/0x20
[    1.399157] ---[ end trace 0000000000000000 ]---
[    1.403782] ------------[ cut here ]------------


> -- 
> 2.36.1
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
