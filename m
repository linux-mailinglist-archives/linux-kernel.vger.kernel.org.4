Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197A362DD36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbiKQNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbiKQNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:50:59 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA31965FE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNJYR4jFZLCKUtbiJCUI8wPYiEKN1GX6hsyvrp/OaKlul5/3Di3+K2KICvvcp1b/h/wokkTxaRMLR++tSFjsMb5ee199aJMYPKWjxgqVcRBiXGaDfOo/UzsmgzCD3nWZyWqunfZRtGW4reJbqh5zUQnL2d3KqKT5TctOiE/5XMffb3ioHD4WFNyoFXaYyKFE0NCvjtMz59UiKM2kagXqQ8m3dbZufmVXJLVcss+oq8EFXLkEyPe75dOloFSXFyGxhB9uz7mGxjoMxghjkc1iQogY8orxovrLr5NwY8Yr0FDMuBsEppUnX3bKsWgNdi/E1Okc04h35yNTDrUkJN3/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofcvnwf3QX63P3Nn/kkg3fokokcoLmhBk0ljKAKcG9g=;
 b=hgUHuK7E11P4v/fowOTTFqdaNfasDj9qnGwRqI+CHzlZzJGib+/Ge07zCUSR70+QOVMKf3vTn9C1DMwlBbZswoU/dthGSK/EaymLFsiKz+02hsZI04ysbln8qkAt29eK2JOomDCgF2mliqiwIW8Ny/rSJCaDBTqKIZ4iHMrxuMOfuw3BdzgK+aBEwBd1LbktueZnpe0XLmAlyLcgjK/TfL0/rStkcejMBL0WT8WHrO7YBmCW4DzOpxoCBhWU7/5B5m0xGqPOxbOVvDjlhzmx0r3Y+icFH5rzoVZTv0RvEzG3JDsWRDAOHKbQm/u1uFPTqLsjE7HUQZH4CctYDaa8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofcvnwf3QX63P3Nn/kkg3fokokcoLmhBk0ljKAKcG9g=;
 b=Br2QLOit8nUSd7DPIEkOlFIUHp6y7Gu7Xqg7NfHLAsZs1OdQDl18WFRkuImDrffoH/cBLsUGa7N6LHyMhlKcay08wLUXVeMGXIXBCnKbCPXTQghGgwMI/gEF4JfXwfKomkfYC/GSBDZ3h5AKWudLM2O/qvBiShbmtg+yZ8X/jpnHVsG8gez1ZKrV3/8lAjizqxkoPvvWSsICJkrgFff2vvotuheAqSxNmxFjzXKFUpuw3YjRGnqZYxI083fqiDRDLlKHbEoEK3Heyryk5lwyWKB0r4sts+wkNtf1j7G9mApgp4gwyBkScVyY0QYDwlSU2bKkvxACq1UsM04WCU2Tbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM0PR04MB7155.eurprd04.prod.outlook.com (2603:10a6:208:194::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 13:50:56 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 13:50:56 +0000
Message-ID: <7a2b77af-1348-bf2a-f50f-dbccd8e2e74d@suse.com>
Date:   Thu, 17 Nov 2022 14:50:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL bit
 is cleared
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org
References: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AM0PR04MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: a6243986-29bf-4910-b1a8-08dac8a2c086
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Uy4rQPPVUEcvC7JSnu0TqZxPtMXVudXq1jeDLMKbDUsHIlqFXzY3f/kXN1qAGinNYUEgaRjjkBeHltIZIMlDKsjB2Dkcrfr2d11h35YxEbJbIMj6pfG8nZksgOLlVAHvTzPEPIaGnMeASs+ydp5eQPB7Yyqp2/srXAMm2CvpHP+0GFAzB0RGD14pu3gReNYdkEJ5oBbBRCy5xa3xFzESz44NMph9F8bDJBeBX27CrNfSzAB4UFO+X8u5epJ+2WNyU62PP4/NpkNNAc2jbctFuh3hmCLtSXIFHEy1Q6B+ETHkz6LLX+TrJjdf0ACOP3Gvlh2lT2bQEG++zabl4xodKN15tLteV8lxZczwJPugBaR+9ok1ONcmS2D7wfqwybacB2dVhQpu5cGSSenkyIRJoWPkd40iWRz83UwxESIN/ukLlp/23Ame3EUkC0f04QmQAWg0+p7xTwECT2vXPzRRb56BBiymUq9oJ6fMkV0S3+wvVrj9MjvZt/7SgcR5SK+OUA72iMF2BdOqz2Js1HCEn8pfOuQzEvibHAohBlQkmbrUNJ+lN4yRPXK2aSdDWX4DWbfRH2cmPRxaDS2rNVrouUUDkllSk6+cD4ph6l4b5vr7tqpayz0DI0PFT720k+hj3fOeugdznjo8FbliJg+Wz2Px3gtBYSvrA1VqpgQU3QF/olVYP88B1pSl5ybRYcHGc1xThkQGRSXzD0xTNDJi2cRFP7Q+CiHkt7eT+9XLD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(31696002)(86362001)(36756003)(41300700001)(2616005)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(5660300002)(478600001)(6486002)(316002)(6512007)(26005)(6916009)(54906003)(53546011)(38100700002)(186003)(6506007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjVYTDQ0OGVyMlljbmpibFlvSkNBSGFCTTF5eXhvVlNTbTZWK0xCZG5uM04x?=
 =?utf-8?B?emp6KzZrNlZSUUhTdmZBVXBNMnhzZXNrb0Y5Q0NENmVwTlNkRE9kVjRLdXl1?=
 =?utf-8?B?MFNPb0tqWm9abmFlYmZTdnBWd3pZd1pDU0ova1M4YWFiVThxc201aFhicC9R?=
 =?utf-8?B?cTBLaloyOWFwMVo1bWlKWVBUNEhZcWQraGhDNUhsZWgySUJzRWNhNTVqaStQ?=
 =?utf-8?B?YWtYdU12cUxYczlOZkNlc0FMMUQ1UlBlbmRvZDRWd0tQc29ubUhvY29tMVh4?=
 =?utf-8?B?Q2lCakxsd3VxY1REV3p5eXJIdkQ4K1VVQXlEbm1LRncrcExuMi95Sndyd2ll?=
 =?utf-8?B?ODBzSG9WQjlISVJEdkpmR2N5UXRkVFdFNFRRTTIyVEpQanA5MUl4T0I2b0pZ?=
 =?utf-8?B?cHpXRk8rbGh3OCs1VGx0bFFaYUllR05ObUlaQlJxWkplNk9LQjlUUzd2RDVt?=
 =?utf-8?B?VEdJVllreDdPcXBFUmI5WWdpallvOVM4MWhMSWZNU0F3QjRMbjNZbVhweW9O?=
 =?utf-8?B?NnVLcFlxTmhKalpFOVpYbmc5dVgvVkN5WjZxcGg3amJZSUd5aFdVUHRsMUI4?=
 =?utf-8?B?MmpscnVURlNYVnVxYUdBTE90RkhrU1Iza1RiTkZseEZuTmFSVVFFdjdQcmU2?=
 =?utf-8?B?QTEwWlV5Si9NMlJOeTdTdlJrUmVLRnlaZi9mUU56STc3bGVPMXVTM2Eyb1dM?=
 =?utf-8?B?VWNHOVJ2KzRhZ1phTnV4R3h3dXZIdlNBR1RTOW1TYjdQQlo0bzRQR1FsczhV?=
 =?utf-8?B?TGZlOEo1UUlrcUk0bzhDVVF1dHZia0syM3J3KzE4VmlGQkF4Y1kySFVQTE9C?=
 =?utf-8?B?SXlqbzI2SmxocGtOcHUvdG84cWRQcUtVMFc3NFk3RXdvbGxHNkJ3dEZsZ2NZ?=
 =?utf-8?B?TE45S0xqaFZLOEtNMDNkdFBaWXU0bVNpUnkwaFRLSWdrcE5XRmpKOExEUzZ0?=
 =?utf-8?B?WjRnbGFIOWpXTk1WNHVxY0p3NlptRVJsSnQ5MEtOcDhMUlJ2d2Vqa3ZXbGc4?=
 =?utf-8?B?T1ZhMkpVMk4yOU9Gazk4RDJibGNRNWI3bTExckVSZTc4dXBSYmxRUWJwVm0y?=
 =?utf-8?B?cisvMzRkUVQrOFk4M0xqbm5iRkFrRjlhNEhqMDJkcitlUHFZaXI0Ly9sKyt5?=
 =?utf-8?B?WHdHMExjTCtVZzlDMHlJRkppMm0yMGNZWDFLY0RXazNTTUpQRjdTclhaT1J4?=
 =?utf-8?B?ZEkwTWxlWnZNbzFvSUJPSXVXRlBhYTAycjU4NXNtRXg2ZVI0U1FkL0ROMW5H?=
 =?utf-8?B?RmhuNjQ4R0NZWFFVZmtreTBQQUk4TW1QdFVzMDRiekR2MUhGQnRvcTRpVi85?=
 =?utf-8?B?dUpzMVQ2SnYrYXpGUTN5VDRNY2NXYzYwZXk1Kyt3NmJFRlZsaWtiWjRaVXdH?=
 =?utf-8?B?TmhtaDNmdGMzR1RlTys2b3Z6U2VRbm9wUW43VjdQK0VCVUhCR0ZiWjVMc01z?=
 =?utf-8?B?cUJ3S280MWgxZWlqcXprRUFoU3dmNk9KMW5Ic1FoTStmRGh0b1VObFpkdDkr?=
 =?utf-8?B?S3EvN05FT0V4ZnZEeDl0RTAvOTJEYVNaWjF1d2IwS3pVeGRTSXNEaEU2Rm1X?=
 =?utf-8?B?SCszOHR6OENQWEVJaHg4Skh3R3dNTU5tRTJ3MXRaSmxPQ0lpZmtwODM2VjFn?=
 =?utf-8?B?UnEwc2UwSFJVZlJ2N2FrT0hjYTREL1h5eWFQdy9MK0ZlZUc5ZlB3T1M1bS9Z?=
 =?utf-8?B?dDFRQkJ6V1E0dXV4MWdpTVR3NWEvMFBwQmE4Rzl1ZXR3UFB1QURVc3ByVVNj?=
 =?utf-8?B?L3VXZW5ZVnN6Yk9kTlVyb0VNcHdYekNPRG5hSXVDMUFDaG05TG42Q2xaYm1D?=
 =?utf-8?B?aW14WnBDL01WVkZkdjY0QTBPdFVVTHErWVNOck1zdkVEdzlXdzJycm1VOEJZ?=
 =?utf-8?B?dnA3VVBwY1RIcmMvVFZYeUNZaEM1eHU3a3ZUQzgvU2s5WitIbG11Zk9SeFln?=
 =?utf-8?B?alROYjFLZkp3YTl4RjNYS3BOUkdNOEplVU1qYlhRRjFYZ1p6VERiNWtOanMz?=
 =?utf-8?B?MmJObWhDOTNYMUJ4SWY5WHZHeXVZc2kxVHB0TmR6bUlpMGNlTXU3SDhrL2t3?=
 =?utf-8?B?TEdjQkxncEJuTHdLc09UZHZKSnlmNnk2a3pnS3lPWmMyQnlheHdsbkZqT1Ur?=
 =?utf-8?Q?z+fWDPa8DmiBAooOsb3iEPWQ5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6243986-29bf-4910-b1a8-08dac8a2c086
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 13:50:56.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi3eohJgDgQSLd0k0zShI1Q3Bps+fasvh11YL5WPvrLblkSrWm4E7AkzKo5Ge6y00R3MswW0DTfsekOlHM43jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2022 12:41, Marek Marczykowski-Górecki wrote:
> --- a/drivers/xen/xen-pciback/conf_space.c
> +++ b/drivers/xen/xen-pciback/conf_space.c
> @@ -313,7 +313,7 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
>  				&val);
>  		if (err)
>  			return err;
> -		if (val & PCI_MSIX_FLAGS_ENABLE)
> +		if (val & PCI_MSIX_FLAGS_ENABLE && !(val & PCI_MSIX_FLAGS_MASKALL))
>  			ret |= INTERRUPT_TYPE_MSIX;
>  	}
>  	return ret ?: INTERRUPT_TYPE_NONE;

Considering Andrew's reply, maybe it wasn't a good suggestion to change
the code here. If, however, you/we decide to keep the change, then
please add another pair of parentheses around the operands of the left
hand &.

If the change was to be dropped again, I think ...

> --- a/drivers/xen/xen-pciback/conf_space_capability.c
> +++ b/drivers/xen/xen-pciback/conf_space_capability.c
> @@ -242,6 +242,10 @@ static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
>  		if (int_type == INTERRUPT_TYPE_NONE ||
>  		    int_type == field_config->int_type)
>  			goto write;
> +		if (int_type == INTERRUPT_TYPE_INTX &&

... this would need extending to also cover the INTX|MSIX case (i.e.
if a second such write made it here when the enable+maskall bits are
already set).

Jan

> +		    field_config->int_type == INTERRUPT_TYPE_MSIX &&
> +		    (new_value & PCI_MSIX_FLAGS_MASKALL))
> +			goto write;
>  		return PCIBIOS_SET_FAILED;
>  	}
>  

