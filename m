Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6857763F5AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLAQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLAQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:50:09 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B74113F98;
        Thu,  1 Dec 2022 08:50:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMhyG3ic2Cs1szrLHJGlaahqzxTOVo2fNCIC/VsNxI7Hl2u302Ib6F8BaRrayhs/0L3SAGpJOspMf8i6atxpq93S8AjnhVBNERRhYMZYPN4Xq/7kFzohCE8vJ1RofwW72R+pLwTBb51xStWSIaJyg4PJPnrsPYVUWVuVzZN78wyzS2MMV48CATAFdRZJdW0FnXrdw/XA6MupKWSCFIZP+rO/ikejMsz6lP6nqptFQIYmyjF9DaqE3v/9s+LOzM3j4dezILyNLRQsDjXcdFOnsQ2ZYL1CIhsSDNG6r0YxG8wQE7iKk21wrOodAswa+hjcw9sPCrWhrAENTFnAPJhNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRW06KFw6Iv1/iKi4Gng4acL2n/Zr58HGd67yhCrzEs=;
 b=TVpvnOtmu7xP+JgK+EiSQ2hSkOvfvz9P5GCxFYaTGCVPF9N/5YrxFOnDXAY5govTXu2LZ7hV2Swu/iuqe37VS6jp1sQhCNsl4YBaOVkaebfbnhVzcX8+YR3AIR4IpVDIlD6WPNnN8KWRYX1DjZJGrdNAqEGkx1i0ac0yv3kjllsMToEempLCPOhspNV5DuWR+aYKRr0gQgCUp2quv0F/RMBMhc/cVeWu/957ao0vWDesE/JfXEkUhSMYbx0Aood0jggBRqc4EFefAt4zPjoRHe78yE/vYh/ReKoMX9ktkIxapujVe+f813YzbMLMM4rguQpkpEcaigywlyWczYQf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRW06KFw6Iv1/iKi4Gng4acL2n/Zr58HGd67yhCrzEs=;
 b=hp7/QcW6fIWt+4VHiQ5MIF+Tr5B/RYaVGrsu2GcNg5dClxCXDx8E2EdcCR6Ca4amkyjPSnEx68EEKT1A24XtgdMXsWFB6V1vNOsS1nAB+B9EI6tKUNDvQf8Jmy5mJYevfAX9cMEWs00IyYPrbP6M1fsIv0OQ2QDJiBGIDGzQhVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH7PR08MB8279.namprd08.prod.outlook.com
 (2603:10b6:510:15e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 16:50:04 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%4]) with mapi id 15.20.5813.019; Thu, 1 Dec 2022
 16:50:04 +0000
Date:   Thu, 1 Dec 2022 10:50:01 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     ye.xingchen@zte.com.cn
Cc:     dmitry.torokhov@gmail.com, colin.i.king@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: misc: use sysfs_emit() to instead of scnprintf()
Message-ID: <Y4jbOX4ePJz7vbu1@nixie71>
References: <202212011548387254492@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212011548387254492@zte.com.cn>
X-ClientProxiedBy: DS7PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::17) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH7PR08MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5fca01-2008-4368-3330-08dad3bc185b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+sisvWzJmkGTxJ0Vy/j//jF7QdLAUxkSzACaD1Om6QSdq11pp9c4y/rVqnOsW2aCK535F1ahpnSeNY3UdF6PZZ5oLW/442sZoNXiUY7XrSdxQvJfyGqoNsm9vXNoLUI94ygVU/phKByU4EDpRpUUxhxq2d4qnrMFD1rc0+UaOmJYEO/sac8GZfb5iloJs+k7LG/V8P8UNG3y6GFKWIvK8pd5rrj3OJ2d6CepQP7AlD2GDoZkaVBUeBI5DVPmUIw1txUixG70D+Ftk5dc5M6JtWkquW5SE6Cyi/EE7shRBLrhYdH4xv2fgGZEetOFsWiAflEEFTtti3//pIjCPnytc8W31aQuk9wQ81GFiAhh9oFwLu0B059LIRDvpT/Eqznzj8DZ6CnFZ1m4c8Rua1Ohs54JCwikOtc4AiQtenjrSdEkeke7y6RRsWF/1dVlzCy7LBcoN5oHewJQ1pV6TKWe7cROfI1ujMBY8tJmFZ94SFruOr/01OnEHBMz63AXpJd/OzZhARDhkBU4cr8S614C4mu4L2Hqf03KJwMce28atsDxyx/8pt140KRGEokH6oDhWKQYg0DCt9rMefmoz9a4KJTNr7d9/qRKfnVveXGEgo+CDCxSkjWmt2Q+LuC7bERGl8A5y/v1DKqwD00Lcy/DRtjY3vu0Axm7nhIqLptT6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(376002)(366004)(39830400003)(396003)(451199015)(41300700001)(186003)(66946007)(8676002)(6512007)(6916009)(66556008)(26005)(316002)(9686003)(66476007)(4326008)(83380400001)(5660300002)(86362001)(38100700002)(33716001)(2906002)(8936002)(966005)(6486002)(6666004)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5SxbkVtsLK4fxj56ixMAFc8jUW6e3FyhwigO6N0nsY3XY+KRkKWd53DGrzR?=
 =?us-ascii?Q?qe3DeQesz9iBHfSUtvWhfcbfri+pdztRripabh9OaRgkGtDHqcLnCAPx5lPv?=
 =?us-ascii?Q?oe+P9mmxBeX1vmWgk7ehIljil4q1HC5KRh66+mjeSrbbRR5P8ap5KFJsqyK4?=
 =?us-ascii?Q?E+U3sxnlpVAJH+W10jMpZpm0r2NuhmNty6YJRuq0xRoHK1XkvSAphiIpkRg1?=
 =?us-ascii?Q?KJmadaKEkBWv/bdlJQ9W54+g+PZqkVv/ELd/oGjgCgaUXkXp/cRMt43DBXgX?=
 =?us-ascii?Q?YD17PyhEVDbNLCt9URhtffAaMr1H3pTLRCu777FhfPEAOrGLVIdj7j2M66WK?=
 =?us-ascii?Q?TPwRzVgERR/sO90lobYxr/fCmPnVz5vUIgU31x1017Em9EKmRHEYxbruQQpx?=
 =?us-ascii?Q?5yRyZJ2FeBWUD6dDEYpxoLL1XYdWyjQI2HGMBzxIA+SC8FKHN7GhGXeyb0lM?=
 =?us-ascii?Q?Aeq0IKFPzqoooWU9kD/QV9iE0XGe415CRVi+KvHwbcvt6ercScEZyMgAlC1K?=
 =?us-ascii?Q?ytCYH9WiPDGQX2JSuQxkPcVWSB+OyFE6O171BSYbT3nXxujo8wQAgxX0/onS?=
 =?us-ascii?Q?kwp8wCS6Xl0kNgWS6AChRtF7jTBzPpApNa6PrIS0RHFBG3NvNIWSi+Tjx6fO?=
 =?us-ascii?Q?kw5lZTZ5+7sKBDOVIYGnF2uJK5uad1esptv2fD90IyOSx22KlNinaG3AwJE4?=
 =?us-ascii?Q?ORwsNIT6r6pQlI4Yl+RkgPy/gJ25STc8KNUk8Hm4v2BLs8OLcMW+wXb8VyxU?=
 =?us-ascii?Q?NX1MFhBEUxDUECsl1zApb85ASoHMz4p9domV4pWFDJlRzu3fYC4I5RIZhpWU?=
 =?us-ascii?Q?qls1TYT5ZlcTH36pYl1yW43v4k9eOmM3k/mc9KTLkFS/yWYUHzCRawnpTuQJ?=
 =?us-ascii?Q?bmUEyEvt/LweL0aeYabTzeIBYuCH7Z7gHDClt5+QTF+1/7FdD8i8FZsQ8oPI?=
 =?us-ascii?Q?tujVmQsxXVRq8a9VFyN/BtLg7EQ1M4///R3p4iZQZxgBbtQ1xZr2xVbP95u3?=
 =?us-ascii?Q?suqJSHE+0sGfBcQQr7eKrkkdwr6pXUOWnAh+XpVXv7cpmxpPECK+hu+oA8ma?=
 =?us-ascii?Q?KT8UutwV/16cWXJnrbL+0nCyC3p4HtMUcu9wknrRuglJ2TLK31pwKsDEqcyR?=
 =?us-ascii?Q?vqJGRW5hX+Qsh3t9CAO6QqUJ+NbfNGEYS1n8tAgdA9RdGdJd54pFDcJ3fnPE?=
 =?us-ascii?Q?nGfFeaFT+T5/OY15hSbcQgcm39zy1Ld3ds7TJy+RRfAJmSEaffpG2Yvky5Hz?=
 =?us-ascii?Q?za9u5h3q4hp426hXUqhdfLTjKCrF7Pv5cH9TEJmUEnxwv8sMsky8YJTOt+C9?=
 =?us-ascii?Q?vVzD5VvqgcTu9xw84acZFRnOhQ9Bmd2T+yLIs591YrmuS+v/zOWJ7TDVGJX0?=
 =?us-ascii?Q?wDN54BkddmOsBaBQUanMb9t0c9O22hPiSQx60U/Ola5BHeTtTX09NbPSOl9h?=
 =?us-ascii?Q?MXhIIrTwyOy9cnydHuLoIkXkcrvFjqKXEPof7klVzT2qlDjeF5NB1mZDv6qA?=
 =?us-ascii?Q?0/pkj6PN19fNCXXck/etcvzlSLNp5+wtOzu8obBXyp54qcJ5nQiT8x56+9Ky?=
 =?us-ascii?Q?h+kG+BK1MlmyN1k0J5EzXb2kP2GClnZOBGMJbTjw?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5fca01-2008-4368-3330-08dad3bc185b
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 16:50:04.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAFqjcale80HG2Z2JQHqNDFu0nuaAV915x3Xb1yshjZEawSDXBaEu3VlgrZR+tCO47cn/XKOuS0amvW5/Ti2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR08MB8279
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

On Thu, Dec 01, 2022 at 03:48:38PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/input/misc/ims-pcu.c | 10 +++++-----
>  drivers/input/misc/iqs269a.c | 18 +++++++++---------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index b2f1292e27ef..6e8cc28debd9 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1050,7 +1050,7 @@ static ssize_t ims_pcu_attribute_show(struct device *dev,
>  			container_of(dattr, struct ims_pcu_attribute, dattr);
>  	char *field = (char *)pcu + attr->field_offset;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%.*s\n", attr->field_length, field);
> +	return sysfs_emit(buf, "%.*s\n", attr->field_length, field);
>  }
> 
>  static ssize_t ims_pcu_attribute_store(struct device *dev,
> @@ -1206,7 +1206,7 @@ ims_pcu_update_firmware_status_show(struct device *dev,
>  	struct usb_interface *intf = to_usb_interface(dev);
>  	struct ims_pcu *pcu = usb_get_intfdata(intf);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", pcu->update_firmware_status);
> +	return sysfs_emit(buf, "%d\n", pcu->update_firmware_status);
>  }
> 
>  static DEVICE_ATTR(update_firmware_status, S_IRUGO,
> @@ -1309,7 +1309,7 @@ static ssize_t ims_pcu_ofn_reg_data_show(struct device *dev,
>  	if (error)
>  		return error;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%x\n", data);
> +	return sysfs_emit(buf, "%x\n", data);
>  }
> 
>  static ssize_t ims_pcu_ofn_reg_data_store(struct device *dev,
> @@ -1344,7 +1344,7 @@ static ssize_t ims_pcu_ofn_reg_addr_show(struct device *dev,
>  	int error;
> 
>  	mutex_lock(&pcu->cmd_mutex);
> -	error = scnprintf(buf, PAGE_SIZE, "%x\n", pcu->ofn_reg_addr);
> +	error = sysfs_emit(buf, "%x\n", pcu->ofn_reg_addr);
>  	mutex_unlock(&pcu->cmd_mutex);
> 
>  	return error;
> @@ -1397,7 +1397,7 @@ static ssize_t ims_pcu_ofn_bit_show(struct device *dev,
>  	if (error)
>  		return error;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(data & (1 << attr->nr)));
> +	return sysfs_emit(buf, "%d\n", !!(data & (1 << attr->nr)));
>  }
> 
>  static ssize_t ims_pcu_ofn_bit_store(struct device *dev,
> diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
> index a348247d3d38..e4d5cea51f39 100644
> --- a/drivers/input/misc/iqs269a.c
> +++ b/drivers/input/misc/iqs269a.c
> @@ -1332,7 +1332,7 @@ static ssize_t counts_show(struct device *dev,
>  	if (error)
>  		return error;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", le16_to_cpu(counts));
> +	return sysfs_emit(buf, "%u\n", le16_to_cpu(counts));
>  }
> 
>  static ssize_t hall_bin_show(struct device *dev,
> @@ -1369,7 +1369,7 @@ static ssize_t hall_bin_show(struct device *dev,
>  		return -EINVAL;
>  	}
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
> 
>  static ssize_t hall_enable_show(struct device *dev,
> @@ -1377,7 +1377,7 @@ static ssize_t hall_enable_show(struct device *dev,
>  {
>  	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", iqs269->hall_enable);
> +	return sysfs_emit(buf, "%u\n", iqs269->hall_enable);
>  }
> 
>  static ssize_t hall_enable_store(struct device *dev,
> @@ -1407,7 +1407,7 @@ static ssize_t ch_number_show(struct device *dev,
>  {
>  	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", iqs269->ch_num);
> +	return sysfs_emit(buf, "%u\n", iqs269->ch_num);
>  }
> 
>  static ssize_t ch_number_store(struct device *dev,
> @@ -1435,7 +1435,7 @@ static ssize_t rx_enable_show(struct device *dev,
>  {
>  	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  			 iqs269->ch_reg[iqs269->ch_num].rx_enable);

Please refer to my earlier comment with regard to vertical alignment.

>  }
> 
> @@ -1475,7 +1475,7 @@ static ssize_t ati_mode_show(struct device *dev,
>  	if (error)
>  		return error;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
> 
>  static ssize_t ati_mode_store(struct device *dev,
> @@ -1508,7 +1508,7 @@ static ssize_t ati_base_show(struct device *dev,
>  	if (error)
>  		return error;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
> 
>  static ssize_t ati_base_store(struct device *dev,
> @@ -1541,7 +1541,7 @@ static ssize_t ati_target_show(struct device *dev,
>  	if (error)
>  		return error;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
> 
>  static ssize_t ati_target_store(struct device *dev,
> @@ -1568,7 +1568,7 @@ static ssize_t ati_trigger_show(struct device *dev,
>  {
>  	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", iqs269->ati_current);
> +	return sysfs_emit(buf, "%u\n", iqs269->ati_current);

This patch creates a merge conflict with another one I have out for
review [1], so one of us will need to rework.

My hope is that I can go first, because mine is a bug fix and hence
higher priority.

>  }
> 
>  static ssize_t ati_trigger_store(struct device *dev,
> -- 
> 2.25.1

[1] https://patchwork.kernel.org/patch/13058161/

Kind regards,
Jeff LaBundy
