Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3838D73B029
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFWFjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFWFjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:39:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56EE46;
        Thu, 22 Jun 2023 22:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXSrkdEHKOtpVLIMR03FjE5tSiYZMKO78gCQM76emQTGXVcfqxoTbG8pKKRdcPx9Vz5+/6sukuhuNUhyCWvckAywG2JXJt+T6JUxILChCBXNhCKOepOwtrOY60LLbL3Pkn3PVRQmdNlWA7vsOSW3ImKaUrOmr+n0DIclMDToXRFMPUxAl2pCgueezshCjJ7QiMWAZRfjo2HlJ4RD6C7N47JFtw12Ogmhu9npKBYNndY8WDd6fTqDd08kBkmJGZZGZeMJdlhuGZqoetF7UxDwXHrz5+LkiFp2tDvpGwi9FWoJ9V56+AEGChSqzdXLO5fki8xFmvoucZf2D1a3Q3zmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gtRnrPNa37pqPdvqErR1PNLHREKDMTrPn7bzP/Fops=;
 b=B5n5qI8i3tyVucWSSVrNdcH2yUebSSXWJIsWLei5j/ry7Vz+8FFfHsD7aC54H+VbgC3v/iytlAicV2pDpZgT35CCJH1X9MsDqqLblXEsrwaQ9mD+QL6ia2erNhpOEq1fFvW1uNzxNgtNMaQVw/bl6k+BI5pO2OPknFkCDRgTQGb6+HuMzWgsFsTvbAuxq3HPgMazU0q7vPhdpJ3VnYQUzjGZ6Ptsg2Hi8h2Pag2tY1eeFI24Px3TwYt6TwMHSkPzP/W1op6HCMGAbOg7QNSREojdF94Lsh4vgGtHHqGWEfsdNER7HTevp2LjaNGVTkLDU7uNZepSRMAVjWSAvifudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gtRnrPNa37pqPdvqErR1PNLHREKDMTrPn7bzP/Fops=;
 b=EWX0sNKTSrJOqhZ1F9MWQDv5mC2W9we8CFbzRRqP+uQMGASpinqymjRN0yjgSHvA0JNXW/37WwdpnopJdj+/j47o63vAc6b257OPaOsWMFbbQwJ2w52b4EYMmY5ywCcnT+9IIH/sp/mCXixAYDVrN2PmWLSeVCVsOYVf+ysTPm+XENZunkHMXuYY1rcb5AvRoQPRZ8xAbK/dEeuFC8/hmT9ePb2AaTNanP9us7F0mjBhAOzYMDspdcHueDYo+f1UasHTXoqajT4lFYjxueTWzCmQydCSKwSX6EUmSGusPHgvoq5IULAPtEpvTHyQLzYU5VHrfSMsmDhyxsRODOt4yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 05:39:44 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::bda0:2d44:96c3:c3fd]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::bda0:2d44:96c3:c3fd%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 05:39:44 +0000
Message-ID: <7893c366-e6aa-d606-c3d6-e85f73a345e0@nvidia.com>
Date:   Fri, 23 Jun 2023 11:09:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/8] ASoC: tegra: Fix AMX byte map
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
 <1687433656-7892-3-git-send-email-spujar@nvidia.com>
 <ad4b4dc9-7466-45a9-a008-c2301a7485dd@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <ad4b4dc9-7466-45a9-a008-c2301a7485dd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::14) To BYAPR12MB3205.namprd12.prod.outlook.com
 (2603:10b6:a03:134::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 71079866-6326-4e96-26b8-08db73ac3f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7r0FFPc3go5WaGTu3DVRsygBWkUWXkynp3q4xJWyaYtQWxN/1m/tDwRS4mYF2oYCTxdnznMThCys0NOmB5OPvNfgVdS5n3bzFZOgHbu5bIwB6VQDuf/PbZ+6tPEsqeQ89Rk2Ytdt8aMmwfbg7uTLulabNj+B4Iuhrs6E47NhTrt/FtT4wQEHjMinmwxPPNhJGTBzC+w/9MmWPtrhkKQruZd7CEDvHa2kVE8zK6hTTV8JU1fWeWnydwVGskIf0pFqJTigZKNbnIGuWHQx07xgndXFf8a5yA5AL0k3O01WDpXnT7QuCpvSfwdAA6R3KOvpfLBwknJMKl7pPRUpyqF3k6UvQAsSnVOlBDTNNcwtU1tcKev2ZI9Ser8RC6XeMFrRSW/8TXT/pu3ZGe+daDOLkigQxlzUZb5YXiA8PFuPenuF0IFXAREUoW8mPG4+mxoV3p9HJaYPoAgbxMeBB0NicBUXuHaTOKZYt1in/N5uQuSz9BIF4NMRckA0biP24xNihYJDxCN5QjhUYdXAX/Fy8ya4r523bzxZFIuonUZuhBHOtsChs3ic8CmlVp7GX3YgdAdfsDwYv9ZC9fkELq0qE07yBBw/2JxSVuif7zvZlRTiQQ2wzBPENW2VVGkbu+rw29Znap7Ixuq5/LlWEm51w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(6486002)(6666004)(66946007)(66556008)(66476007)(478600001)(2616005)(26005)(186003)(6512007)(6506007)(53546011)(4326008)(8936002)(41300700001)(8676002)(6916009)(316002)(5660300002)(2906002)(7416002)(38100700002)(36756003)(31686004)(86362001)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHR3RFE0VE12Yit4UTBkNTl0OTNsazcrZXUydkZWTTBkanY4ZHE2Z3J6ZXFt?=
 =?utf-8?B?cVk1eS92WUZtWi9qSlIyV2ZqSCtVYWtZc0xTN3c5U1A2U2ZPVTBIbXFmUXo2?=
 =?utf-8?B?MGZxTGtqTVg1UXRnRHpqZzVjdFZackg2N0FjaTZVQUYyaHJoRWJid2k4MVhw?=
 =?utf-8?B?bzNBc2MvUjJJRWhRbjdsR1pubWhpYjZxNFVpM0RkZlAzSWx1Y2hIenFBZUpv?=
 =?utf-8?B?eHpzSEZIdURFbi9UVzVnODJFTVZGRklQdnZvWWlOQ2tMZ09iK0s5UzRIOEdB?=
 =?utf-8?B?NW9haDVZQWF1R2dBaUh1U1JkenJHckNFUkowUmhPR1FYK2o2bzdhV2RGV2RT?=
 =?utf-8?B?VGVpajBJSXFoTTFmM1AvR2MzVWZFcEkycVpraGNQbkpIeWJhVW9qY1RTTW1E?=
 =?utf-8?B?eW10SktMM1B6MnZEaUpkREZTN3dXcmZGUlVvZEQ3T29ha0FDMm1zUko0NHl2?=
 =?utf-8?B?c3g5N1RjV3pwaW53S0JwWGZJRC9GYmVma2JyM2x6aHhkWkJQVklaQXlVcW41?=
 =?utf-8?B?WXNjSzZjSnM0Y2tSa2JxcXBoU1N2UnNzeGFmMVprcVc3bXlidWVsZVU1SHJU?=
 =?utf-8?B?d0NmcjYzcCtlQVVscFV0amJTbHdPYVZHeE5RMG5sL0pzZWlFSUNsdlFoM0xy?=
 =?utf-8?B?SVpFMWpqK1B0MDFvQm56MzBodU5DZXhmQ1o1eFR2QkVJbUQ5UGJreXVJZmFl?=
 =?utf-8?B?d0cxMTZEUnJtN3Z6WkRhQk90dnluaFp5Z2hMMTRYNndGUVVia3pCaTlVb0dz?=
 =?utf-8?B?NWpJNGsySXN4amxibGN4dmUyWk11WTJsMll2RGNpY1Ribkh3NWlTQURYeURj?=
 =?utf-8?B?eG1WWm1QSzJERFNYS1F0QnMyUlBCa3R0d3IrMk94dnZndVdvUU9YT2ZjUEhw?=
 =?utf-8?B?WDNZeStLanhBbGZrUTlpNC9XWTYxMjRFZGJpU3F6ZjQ5clhhZytYbHdhOXJm?=
 =?utf-8?B?KzV4VjFuTVlBY1lmaXQzcHFDdlBYZUsxWFRPNDNWNGJPazFCZkFWQTkzallS?=
 =?utf-8?B?QkJrZndRdTVyUzV6bi8vMUZkZ1hqSzRwRXhqa0FablJwSmt5UW9zeTB2QXRn?=
 =?utf-8?B?UmlyYjNQWFg2cXROWmQ0QkdCWEJYQkVDOGFGRkRCZWlLQTJmbWhlSEh6V2ha?=
 =?utf-8?B?TzkzNzh0bWVkdkRhSUplN2NuVzcvSVlNU2hWeTMwZ3ZDeWZDT1BzNm12djVY?=
 =?utf-8?B?cjRZYzlXL2hzU2dqeGFpd0h5Rm16MzdXUHJuQkk4RlZFUkNHYzFha3o4RDFR?=
 =?utf-8?B?QWk5emZ0aDRUa1lROFQxWmczR1hXbXBDY3RvaXFkaDJSQ1F5T25xQ3BZdFp1?=
 =?utf-8?B?Rml6bksyVGphcXVxR3cwODVudUdVbmhxcWRZaTZzNTZ2S0d1TkRrWXY2YzQr?=
 =?utf-8?B?a1k5VGUvRDdwZHgxRXBVa1ZTRSsyZXU4cnBpTnpDUUZVYS94M0hYNTRhbVh1?=
 =?utf-8?B?eGhVTWYzZ2xKYVFJajZkdjZGSjU3Y1c2NUYxMXpnT0FwZ2pBb0hISVBqcSsz?=
 =?utf-8?B?Z0VQUzRMbmVFcW9XSnR4TUQ2c2NTTTcvRGIvNWVLSlhzTUlaMTUwRHZqMXFE?=
 =?utf-8?B?MHZWRzJWeDVHalpWaStYSm9jU01FMEk0d1dCK1BYUFBtT1gwQTZIZ2g3bEdZ?=
 =?utf-8?B?c3ROdmppS284dW9GLzNJcWVHazM2YWRyL20zek50TXdKTEZMZzNid0lmQUs2?=
 =?utf-8?B?T0t4cjZSK0VWMlpHYlFHMGY3dWxYOWN2RFlob2NidFc2OUUvc05wWXA4akJV?=
 =?utf-8?B?NzJ3eWpxbkh1Qk90MWlhRjZVV1hBWXNKQTBocm11NHFHelhLMmhVSWwrNnlC?=
 =?utf-8?B?YURUbkdyS3NyK0pJWlBuNU1oVDE1Q3dHaWtYMDBnU0tMSFQxd0JweFFaaVdp?=
 =?utf-8?B?ZnpyOEozQktISmdHT3RLbmtxTDF0NVV5M3FTcXZXNjkreDZ1MmI0elJiT05z?=
 =?utf-8?B?cGJhVUlPVXZXNUlqRFk5c2FGWnFkbHFpdlh5WkFlMHI5Sk5WOVlFNkQrSlpn?=
 =?utf-8?B?KzVpTUhsYTBwc3RSMDJLOU9od215MTRySDVBK1FiUHRKQnEvMXBOWWlYNWht?=
 =?utf-8?B?UU5aU1FpMXpuVGtGcFlzU3ZUSDlONnA1Z2lwRnp5OUloTEduMklYMCtTVTlP?=
 =?utf-8?Q?su4LVqSHyw8JJR91O77DjP6Pi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71079866-6326-4e96-26b8-08db73ac3f87
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 05:39:44.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7s2mLPj27aIf74YlhzTxWtNp+EEQeTeqp7TpNEQO8J6LS9U7wnyWzl5BsYjE982FMZcYR+92tdpmnGvRFvc1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22-06-2023 17:37, Mark Brown wrote:
> On Thu, Jun 22, 2023 at 05:04:10PM +0530, Sameer Pujar wrote:
>> From: Sheetal <sheetal@nvidia.com>
>>
>> Byte mask for channel-1 of stream-1 is not getting enabled and this
>> causes failures during AMX use cases. The enable bit is not set during
>> put() callback of byte map mixer control.
>>
>> This happens because the byte map value 0 matches the initial state
>> of byte map array and put() callback returns without doing anything.
>>
>> Fix the put() callback by actually looking at the byte mask array
>> to identify if any change is needed and update the fields accordingly.
> I'm not quite sure I follow the logic here - I'd have expected this to
> mean that there's a bootstrapping issue and that we should be doing some
> more initialisation during startup such that the existing code which
> checks if there is a change will be doing the right thing?
The issue can happen in subsequent cycles as well if once the user 
disables the byte map by putting 256. It happens because of following 
reason where 256 value is reset to 0 since the byte map array is tightly 
packed and it can't store 256 value.

static int tegra210_amx_put_byte_map() {
         ...
         if (value >= 0 && value <= 255)
             mask_val |= (1 << (reg % 32));
         else
             mask_val &= ~(1 << (reg % 32));

         if (mask_val == amx->byte_mask[reg / 32])
             return 0;

         /* Update byte map and slot */
==>     bytes_map[reg] = value % 256;
         amx->byte_mask[reg / 32] = mask_val;

         return 1;
}

>> Also update get() callback to return 256 if the byte map is disabled.
> This will be a user visible change.  It's not clear to me why it's
> needed - it seems like it's a hack to push users to do an update in the
> case where they want to use channel 1 stream 1?

Though it looks like 256 value is forced, but actually the user sees 
whatever value is set before. The 256 value storage is linked to byte 
mask value.

I must admit that this is not easily readable. If you suggest to 
simplify this, I can check if storage space increase for byte map value 
can make it more readable. Thanks for your feedback.







