Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FDA6B864D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCMXuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCMXuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:50:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDAB6F4B0;
        Mon, 13 Mar 2023 16:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxxihRhs7AD7N7NVMSbfovw04c22yOsMVfkTK8D+nFg5FWt2RYZDK0Y78HrgE+UwfO1J2HRmPhn7MockDCtoY19N5cN3WstgAgqC9l83BPinMu3ygYYNrhIMnqPWti3ZT79fpA7D0R+NXdOt4R2s0c2FHEbGhQ8PUA+KWR1xBw9sRk7nFAACEhBjAgFUn8cO0ieh70OWrvpt3XjOitsWr/Hgc4LGK9p4ZwQGb7Dyl2JgU2P7vQIILxZJifR0V5ip3Fjdfm5As+WsVeVL2L0Mfvl0FL1cRW5d5TRWSF6szt/Eegx03EGExW4DXXDtiEBaU8W7eh+o4QMnfEwn0xayKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpp9c+iJbShAA3cacuEpbbk/yHfd+Rzb3/AceYdY538=;
 b=FWEtZRV1np/vUXzow3gUdTzB7o3b/oA2TpgI58d7TFz3k3qoand5wlqEhlHVuWqbQKB/jKdxxis5QU3DmVemPzhudliBSQmjkqYQxQRUO/eDvlUZCgcWvILXTYe5EA+9B2ZkfYdojnTeKOOYUD7m/C8xN1Xm/4dYWiXTrUBYkHDTcQt3fo4LgC1ZCg10mGWRzYWnCBSsRNf9THsA4pD+dNndjUAldfidyp917dQ5x33uTfW5FIdUUV4/ELw33f7Ri2YeWgWFKwY9ESCYs0MlBFZ5FBo96uq+/PzdRYadJfYP2ecNJ2NmJSBp23SJx+eUwuDp13pNpbxxz/xQz1m22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpp9c+iJbShAA3cacuEpbbk/yHfd+Rzb3/AceYdY538=;
 b=jFdcqZOfmCcQLEtE3fENvVdmZqj7XC2scY8WTGxRtL17HZm2RZ2D2pnz0vxAssW5thNdYxgLYGQtrZ+5oYDdQg9yXiaU+il+uffSxGL7TqHgydO92ij0Jma1OPKDICpsnfzctVZOuNQH8iKg3tv6bgYlnE+c/naR8e5hmB3e7R62fMFYGa49o+3ctw/XbvQzpc60hCuOb90e+AXSRwMR2eT9mfcQ5fxR56F+Ry3E/Xkj61ERknHaMy3m2xCC916ShlS10akIhIdf6HwNAed0fgez3qRGMev6gFALVWSo6oXOhwcDzLXWNnp7sZmtISe+31NxzVIxnceaohMxwbknYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 13 Mar
 2023 23:49:54 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 23:49:52 +0000
Message-ID: <798dd219-f4aa-39b3-2368-7a6d072b6de2@nvidia.com>
Date:   Mon, 13 Mar 2023 16:49:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230310190634.5053-1-dipenp@nvidia.com>
 <20230310190634.5053-3-dipenp@nvidia.com>
 <CACRpkdYmC=eLiWPPPRG7DYBmQfPNCN4pcDhzTCO=hkQDx2HoGw@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CACRpkdYmC=eLiWPPPRG7DYBmQfPNCN4pcDhzTCO=hkQDx2HoGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c6a1df-ff2a-498e-9aae-08db241da3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXQ6duuCBs/fERTlCBOMQwsMLE8N3ZsCA0qn58oLWSrte9JEh6Yfm9URrsklmJWEr5/tWjRlN9ZuTLL4HI5O28CT6P/+OsJTh8sFhSEg+mAbHkNx1WeyboDeZ7TJnUzPdTscrOTOtrUwto8UFvJp66o+Bt5LZndgc6hHq719ayiZqUHO5VtLQQfJzRY7Ap3BzmIAQE6sN6JuhE/+dBkvq8KQ2egXJEF07iUtv71NUcQpXMNryM21JyGI6Pt8kPeaC1DhNDJ4wZpE8apSH6lm8C+vk8o7/bPx/+M4gI2f2f/0NycSZzFbxdNTYFNjTk9kygmCpixL1MPO6FYpb3+AfooFEDEUiR23E2zz0v2DxdMZIs+Oe5oOBYZcsf0pQGPowntisBnBrSGIi+ozlKhkZaHmzb74eLR1qW0Ec78IUHl1X9Nva2GX0FtMhudyTpgUMdmcrJ5Je+4bOzEYC46XDnh2cboQ7q5eN7KI9lCGxbrj2lmP62//tVUxWZKwMfuKcL3SxdZKHABChO6Tc672enQPo12gL9Gj2KQ3TryQ1zFIA2lDZfqfQblWv7RIj7fqTcglXMdUTLWWOtIHP7PYRUrTZ3g6h0cvMjrChSKm7jpAdGFn+cidOGbkbf2ZiYgokPTkXr6p25LW0npLYniK8czndMRuHHtjeyALWP0oGlTPnm54aWnpUKlIrL/oCm63jePPsrB3Et116LK81Hi+Ebh+J00nE7SwoZHWz4A2+tI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199018)(31686004)(316002)(478600001)(6486002)(6666004)(83380400001)(36756003)(26005)(53546011)(7416002)(31696002)(6512007)(38100700002)(2616005)(186003)(5660300002)(4326008)(4744005)(6506007)(6916009)(66476007)(8936002)(86362001)(8676002)(41300700001)(66946007)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U25qN0ZnS1ZPdmRRMjdFbEtWUGVpdXVrT2k3TUJkRDdNV2lFczRVcjRLWmdv?=
 =?utf-8?B?Vmt4SHp3T1FseTVrRm50ajJwRTJBMStZbHczMmk1SDYxUkJNUHNnZXhDZFpw?=
 =?utf-8?B?ZHNkSzlmaUV0S3luanQ4dDBTWSsvOVN6WkEwaTNQUkNZMmw2VzFJV2F3RGlO?=
 =?utf-8?B?S3oxUEhremljeExRcEp3SnIrRE5ZbE90UW1rZlFITDQxZytmWEVEdUdSSDly?=
 =?utf-8?B?eVZlWmhGTHhxTWJDR3JsZGw3NTVRaUlYZktxTVQ3aFhsR2ZqZS9zMXBIYnBW?=
 =?utf-8?B?Vk1Hd1FiY0Zpc0k1NUJZMnM3YWFzRGp4Mk1zaEtaZFc1Zi81bHF6dXhIVFpR?=
 =?utf-8?B?YXByd0s2eDJOUE9teWNuR282ZnVHeWQ1a0dGTjB2a09SdjJrdmdXVVAwQWIw?=
 =?utf-8?B?RmozU2VDZGQrU1pJYXdXUmpza0JKNjVJNW5UYlcrL3o3N2xXOG56akNSemRW?=
 =?utf-8?B?Y282NXZ5ajVvbzJ3TTNqWldNMUw2eUhsdS96cXJPdVRRZFc3bEx4aG9pWnc5?=
 =?utf-8?B?b1FNV2w0SmtQZXJrL29MTnlocXcvZFhLRG9VR1NHb0RLQVZwdjh0c21uQVo5?=
 =?utf-8?B?MlpYVXJ0NUtVZkhzK0thcE5PQkNNZGt4bnJjVjBMcGQzTnk2NDgrSEMwWitD?=
 =?utf-8?B?cjZRZEZ3cXVXVFo4Z08rMzdGYkt5UE1YUTRuck1GeWNiZkR5UWpsamh1ZWRz?=
 =?utf-8?B?SThobXVYUWQ2MDNzL1RMa3V5UFFXekF4S0kxbVNOL1FQbDE0OG9SRllyc1ds?=
 =?utf-8?B?aElJQ2xwSHUvUmFaVHgyY09CRXpzWnJyYmpZU2lJYTFYYWhWcDhVS3BYQmRI?=
 =?utf-8?B?UFFHQTZYL01tM3p5MWhjc2JNeXRWSHZPRm91SDdqSnV3cGx5b2dyYWN3RUxV?=
 =?utf-8?B?ZVBRcy9EejE0T3Zta1hOVzZIUnlLVU5tSlhhazh5VzQ0QVRGZFBteXIrMVV0?=
 =?utf-8?B?bkV1Q2krL1N6cU9RMkN2YmRuUTY5U3BSQjQvNWtqTUJkZ1pKVUdudmlMREkw?=
 =?utf-8?B?RlFKZGsvTG52MXJOR05HVkNaZGtZTGZwODJ0U0krUUpDZ05IMWdOVUdzZGRU?=
 =?utf-8?B?cmF6b1pnUjFYWW5wR2JyS0hvQWlOTTNxV3laTWRZb2EwdHQ3b1BQUitEOHlI?=
 =?utf-8?B?NTB6Vk82YzE2S1MrSXdNdENxL1Frcm52UHkwRUx1SEJsMWhmdDAyeXNrMVJU?=
 =?utf-8?B?R0s3TG1zNmM4U2IxU0NmUjlKTm5jOXg5UzdFakhicGZqSHNIUVdSbkM2L3I0?=
 =?utf-8?B?U2hmT1Bpcy91SGg3UjJvZXBSR2R6aDV4MXovMVpZRUNLcFg2WmRxQWxhNTVM?=
 =?utf-8?B?RXpyVzEwZUIvdDNmUzRpZTFwR1g5KzArRlNxdGhtemppeHhmVmxDSDZwMTgy?=
 =?utf-8?B?ZlZGNEptRjZjODVsbG5wcTNRbE51U1pZRmtWaGRUbVpsRmNzWTFiOEprVVE4?=
 =?utf-8?B?dnhzWXRnUHg3VFlCQjVOaUFlYWhaZTZERmplUmloc2w0UDRmT2l4OHFVU2g3?=
 =?utf-8?B?K3A5S1Q3V2JBZStieVlEOFVHVE9rTEZIUkg0SnFuTU9PVFBjM3lneUx0Skt4?=
 =?utf-8?B?WnBEdkJ4MW5taEtSb0xwaHFJUDBLYVZTYkVXTm5wN2NMTXJXVFYxZ3RUS1VE?=
 =?utf-8?B?TnZGOWo3c2RCOHdHaHpzdS9hOXFlYW1wYzdCLzRFdEM3QWJuSzlBK3pBRGRq?=
 =?utf-8?B?OXI5aVV1ZmpVdE5xamxMc2U5S0MrdEFwaXdLL1FYNmI2bFhVVFRNbkR6eS9S?=
 =?utf-8?B?MFhZb2psNG92c1Jzcmo4em5GdFdmc2tKbVh3cjZZLytNejg3L3R0SHhFZW9N?=
 =?utf-8?B?LzNNbGtPeWt5Rnh0QUNqZWxLRm9NUXl2RGF3MU11TThIUTJPclZXV1FVNTRZ?=
 =?utf-8?B?VmZGM01oR1R6dDRQdTFUSGdwa2Z2QStWTDczOXQ2TldRUCswcTU5NUN6bkZR?=
 =?utf-8?B?WXhNZWJqL3h2MHR0RHlXR3Faa0x4Mzl0Y2phdSs2Vyt2M2NHWEVNNlpSaEUx?=
 =?utf-8?B?REkvUXNhbVhDVDg0UW5TTHRVVko4TXJSUzBtbVZBT3RUbVpqMEhVZUhaaStZ?=
 =?utf-8?B?WU54TFNQTTJSWmJ0TFhoRWNaenhzakdmT0VoSFphcFRBSVNjZFNJeVRuOGdw?=
 =?utf-8?Q?qSj8JZEV7Oeh9+ydb/w4N7c53?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c6a1df-ff2a-498e-9aae-08db241da3d3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 23:49:52.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsqv0oYHytIWJoLRG8GQp/PwjrlXdOiiSnp99jzoP3f1X6NRukKhX6ExdlOKnIUVKLFgREISWlSrz+nmxNAuUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 2:57 PM, Linus Walleij wrote:
> Hi Dipen,
> 
> thanks for maintaining HTE!
> 
> On Fri, Mar 10, 2023 at 8:06 PM Dipen Patel <dipenp@nvidia.com> wrote:
> 
>> -  nvidia,slices:
>> -     $ref: /schemas/types.yaml#/definitions/uint32
> 
> I would not delete this, just mark it deprecated.
> 
> nvidia,slices:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     deprecated: true
> 
> (And remove it from required, of course)
> 
> This way you do not need to explain about why it was
> deleted, it's just deprecated, which is fine.

Great suggestion, thanks, will make changes in the next patch.
> 
> Yours,
> Linus Walleij

