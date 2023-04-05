Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D836D868D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjDETKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDETKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:10:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3484224
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZp7hpQYAgVAUOTFfbA4BvDZKFjceCxKS3fdI3KAcHLieTknakSBygXEYZQzpKAE9Azo0QcwEtJCZIvlEFw32EUKrNhfKQDiQKiRmqPdD96+EGZJApGW+Pa8r7f+x0ZoKNAwfJ80yP+k0kHjY1RGtCTLu0OnsOGqlhk/ju2jcQt+MORx+QiSjVKgaShd3ztg5HCl6kiJlqZ/d6kbBuVkGgyRktMj5dk1bj8YzSTIQVt0iXq0aPVBWiv/eOQN6eT8/4aaGezkIfxmdSSco+VAQ06j12GHcTkNoSNTOABtfhnHlv1C8i+Vl4nhh3gMU+Hv1QgrKTYaeKg9mZ5fWTALmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PYBrjTznpe3pKrXSIQuhDzoDTnADWqlu1x+nO0IeX4=;
 b=cqSKU27tsDHXKX9R3gxegALE2vLt5/rIJbMoDz3XPR3st3pkOpz2P/q7tt2qnmiwtuzIVjUviZIfdjvamkTM9UhIXiNsfa3O3161fJ79QQcScUmUdmzXA3Ffb6fTdtn4xCfSQEq6siG+CYjdHXNv5KWaIevQmp8ZFzqHde21DM46kEcc2HybuZC5/xYaTkeBUV0XmE3PA040AdvCn85+UieiCBfMiLcGjz2W4eooOBRPbvszHF01hv9rs+P/roOTYi76mLg7+Ta4smtbtsB1VrsWThqJjlx5ToBQeOUcdkAVi5ppLhWcO8cxhsQMPoYeml2AQvrKGEqcZcUZWJD/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PYBrjTznpe3pKrXSIQuhDzoDTnADWqlu1x+nO0IeX4=;
 b=QJqbqoMO7NGEzoSqXskSo0PnX1GSHWWRNtvdmBDqVBFOvfHlft1WrXMvvBWT9/QgD9SGsAwGnOtPw4Nb87Aap9vi9ragZINRC64qLF4WpCoHPYrTQjpbKKf6VXOHFdKfBRW3OvUJPrmaTqUjOtUyO/IF0GA8VokpJQ49GujA8iE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Wed, 5 Apr
 2023 19:10:11 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b%6]) with mapi id 15.20.6277.028; Wed, 5 Apr 2023
 19:10:11 +0000
Message-ID: <83d4ad40-4812-0583-ba4a-da3e79732e51@amd.com>
Date:   Wed, 5 Apr 2023 15:10:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     yazen.ghannam@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
 <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
 <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
 <a8826972-376a-5af6-8e61-d74520e355df@amd.com>
 <20230405180648.GEZC24uJ+GSMZxczaW@fat_crate.local>
 <05c682d7-bddc-d990-37fb-cd1779f7e604@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <05c682d7-bddc-d990-37fb-cd1779f7e604@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0979.namprd03.prod.outlook.com
 (2603:10b6:408:109::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 339a6afa-fbdf-4c0b-d0db-08db360960b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZ4nu6wYE/tOGVZxpK9BU++EhOVbORI1uci8Pp/z1uLHE2GPFTwZU0bYaLuRy1SB41w68VnJDBMBHSlCTL2quwPd9kJWPhlhneIi1ELY+I10dc6nXkpZRU/ApnWkf/MG7e902bvTmgfQhwYS0sJUgU7YVkXZkFhxoQf4cEZfmcHQqgs75E8fTTntgxMxBoc5n1xWAP6FqgRGZXnkh+w/u1TIJ7dZGZrX0BCfDgYHVgL/jp5+dqUoHjlQISEnf50j+TiH7IYT9bd03WD8Lx/upT3PIaqfP3KxYDH/ZIV17f6Erz+J6pFxpI8Al7pKxQdR1rdDEKnSj7i7AyX+cXmE/BkBvyiO8FE+jqc20+h/VFpu40qfrKwy2vgTx2iHBUgbiQAb58EGe6HtGr5no2s/FROkUnVBPVquTyyavy+lyHsNS8RicuThZTt0bMgl/0OfQJIDKx+lY5O3Q2zWLS/B0K9Kc+4simIg/E8M1/IbY8u4I0S0K6kLhps6PmBaeUtQzTPtsuwCsWpRvnvJarcIsx3Uh0fEcSsUJwBexTs1egxpEkwEpLOKPGVeR21LpOA8q+70sqrx5QDr1UECILiape3yjF4VRNfOWS73hbr9HiLRjRLh5nWIIdRGs3B7ViDFf9BluBp10MM0ChQWw5gbow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36756003)(31696002)(86362001)(38100700002)(478600001)(316002)(6486002)(41300700001)(44832011)(5660300002)(8936002)(2906002)(8676002)(4326008)(6916009)(66556008)(66946007)(31686004)(66476007)(186003)(2616005)(26005)(6512007)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZ6WnZBd2lXNmpHWTcyZ1A0cjdTWWlNbkdZQ0VOYmZ2RHoyNWlaYzVFTkQv?=
 =?utf-8?B?cG5WcFVjTDlmYU5IUzhUQ2tpZHJLSTZYdWZtdG4rOTVadzlUNnhXUHBzRTA2?=
 =?utf-8?B?WkRTSzUzZDJkQ0NzZGpseVlzd3ZPNzFwSmd6WkN2YWNhLzdhMWlJMWY0Sy81?=
 =?utf-8?B?Qk50WDV3aFhHckhPRFpFYSt1T1kvbGJ3V25QSjBHUjUwMitaVEIvM1FQemw0?=
 =?utf-8?B?cG5KRFJmcjh2aTRUNXRObWZRVGFPc0ZaQ3lLQ1V6ZWZ6NE9lbDh1RXNTbGZM?=
 =?utf-8?B?MWQ2c1d1SEx5WjRFTmNpZ1NrRWhNTUI3K2xjNmhPa3VMMlRBb25GeS9CekIw?=
 =?utf-8?B?VXdoQlY4NjdNN0pTMHlGRGhSWEZWcVlkR29jWWJjRkhrU3ZZQU5sejNpYTZi?=
 =?utf-8?B?UW8vSE1JRmw1S3E4TW93Y29DM0xtSExsM1dlQlc5Vk1pTFI1VUJXZW9ma0xa?=
 =?utf-8?B?dXBiNEpvRndoU1dQQnJuVkJidThJZXZrbUpGemxOMVFOSnVPVXd2YnFjd3hR?=
 =?utf-8?B?ek5RQjRtR2N1MThrWGN5aTE3SDNkNSsra0V0NnI1SkNQTllDaXRqTE1kV3Qy?=
 =?utf-8?B?NXE1RXRoZ0ZDeXNQenhrOFhUNTNLTUxpQjN6aFVsalpXbStGdVhDMkNiU0lF?=
 =?utf-8?B?Q0dvc1U2UnpSR1Y0b0NiSHF3TFU5TVlNa2x1QVd0VW1nSUt5SG9CMksySFc1?=
 =?utf-8?B?ZTNaN1kwNjU0dGpuMnJoL1pNMkJZaDRMM1QybEh3dWg3UUwxSDF1ejdTNzFF?=
 =?utf-8?B?QmF4TlpLRmJlTElpK003YzhmRmRIb056bXNoTU9UUG9WQ2xEK2k1anNkVkZO?=
 =?utf-8?B?Qkx1SlQvRTB5SExzeXNwVnBlYk5FSXhFczA2ZEhIUktnTXJOaTU2ek1ZOU1a?=
 =?utf-8?B?YkQzcHpXN1hucE5zNGhhMjNsa25NcnhhSWxFcnhpMUcrQUsvdjBTNUpINjNE?=
 =?utf-8?B?NFpDb0FRODNUQmVJS2JUTHk2NzhEUkNmYlN0R0VnbUJBY1laYjAwRVZvUEV5?=
 =?utf-8?B?M2pUM0F6ZkJqK1lOZWxGZmplSUNzdWFKdkppNTBmY0tYb2JhdDF0RzNSbnk5?=
 =?utf-8?B?T0lITHBHcFVKc2dCYVJDYXVDMHo1UHlSTk9VMGhNQTJaa2ZvcGJmVFloMjVo?=
 =?utf-8?B?UmpCbE9WTEtEY0xzOVJPYkhQbDhwNS83UFdDVGREV0xUaE11N20vdGh1Ylgx?=
 =?utf-8?B?RXBCeGNnQXJqRzJmWWpYM3RWMGkxb3RJL25QSUN1Q0FHOGJsWXNKRldZZTRj?=
 =?utf-8?B?b0N0TDVkdlhYUk5ka1pzdEVFVHRjamtsZlN3dStSd3dKV3pQVWF6d2ExS0tX?=
 =?utf-8?B?emFGU2tSc2YvQ1NOV1I2OW5hdjZwNGwvcW9CSzhZekZobzYwY3l0NkFjQUp0?=
 =?utf-8?B?cWE1M0w5T2JnSmFlb1VLZENqcUhzRUhvbWNoL1pUcjlVUjkyRTNVY0p4cHR2?=
 =?utf-8?B?bGtndHlnVjc2SURvcERTZjZXYlBQQnlpcXA1Vm5mNmVVTGczenpUVmozZW9K?=
 =?utf-8?B?YU55VnN5N3d2SngrakhuV2tWQy9qUDJWUENSby96N2d1ck5pNXJnbDYrbFdB?=
 =?utf-8?B?YlAxQ2xSdkY1dis4MGkyYTVlRDdIMVgvWFBHMU02a21hTU1kZEtJK3JxNk1D?=
 =?utf-8?B?VStuNmF0UUl5aVhsanFaMHQzYmpWSWFFa0tOUlYwVEQvWnV4ZE9rc1hTVlNn?=
 =?utf-8?B?YXJadU5vYkQzQVkzOE91a3c3VUgxdlZoRjdyL1crc3ltazVXQktCbkdPR3lI?=
 =?utf-8?B?NnhlbVJCSHNlRDcyRDNieTRIZVJwNFRxeXFRQldsVEpBZUxOaHNQeE1UazV2?=
 =?utf-8?B?YkpWQTIxL2Zyc2RjQWZjM0xwVjVjZVZ6RHNFNE40Z0pIM0x0QTBybVErSzB5?=
 =?utf-8?B?T1YzNnorc0NKbUNjbllaZy9DOTZXejJUQmlYNlcza1k1azdXM3dqdUJseHY4?=
 =?utf-8?B?S3pVSy9TTTk0NkF5dFpxVTNPTytXcUJQMFZHTGdvMHdVeklxamVnY3FjZkZK?=
 =?utf-8?B?cGxuWXBZUERNNDM0M25zT2QyTzZ0cVdSaGpHSXNEdit5eXNnZlhiZ09PcTBG?=
 =?utf-8?B?bE1vOEpOaldycHowV0EzQU5CamhidXN2ajlpendJQlRDTmpnOTBnVkRNWjFS?=
 =?utf-8?Q?BOr/bj7ofOxoHfJesViqHu0GG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339a6afa-fbdf-4c0b-d0db-08db360960b1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 19:10:11.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY8v3P0NBqWT5ZBfnJUEV4eATGF5nkSz1dLlRDIoMU9SpYXipPbdmKLG4DJPPT3Jr7/FkgRBDt2RwnbY3I3iLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 14:32, Yazen Ghannam wrote:
> On 4/5/23 14:06, Borislav Petkov wrote:
>> On Mon, Apr 03, 2023 at 05:36:40PM -0400, Yazen Ghannam wrote:
>>> Yes, that's fine. Should I send another revision?
>>
>> On a second thought, I think we should do what you said in the write
>> function too. Because the write can fail too. So if it can, we need to
>> handle that potential error too.
>>
>> Care to send a new version which does this check in the read and in the
>> write function? Basically what you had initially but with the write side
>> check added too to amd_smn_write.
>>
> 
> Sure thing. I don't have a real test for the write path. But I'll test by
> faking it.
> 

So I thought about it for a bit and quickly realized the "write and read back"
method isn't robust when done here.

Possible issues:
1) Bits that are "Write-1-to-clear". In this case, we *don't* want the read to
match the write.
2) Bits that are "Read-as-Zero"/"Writes-Ignored". We can't know this
information here.
3) Bits that are "Reserved / Set to 1". Ditto above.

I think all these issues should be handled by the callers of amd_smn_write().
They should do the "write and read back" check themselves, if needed.

For #1, they can see if their target bits got cleared.

For #2 and #3, they can check if their target bits got set as intended.

This matches what we do for rdmsr/wrmsr. As long as there's no #GP, then we're
good, and the caller does their own checking.

The "PCI Error Response" for the SMN read is the only check that would apply
to *any* SMN read. So I think that makes sense to do here instead of at each
call site.

What do you think?

Thanks,
Yazen
