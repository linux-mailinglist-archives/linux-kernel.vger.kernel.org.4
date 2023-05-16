Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893E7704B33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjEPK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjEPK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:57:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192E51701;
        Tue, 16 May 2023 03:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv1VxwkWztoz3fOAbi0RYtP0htBmQukM/MkTfBTOY4ZNxsFkqnh9gs3ZVx9iOlbI9Urz3Ej/apKIsgEM+y+P0ib1MQH/KDiOWWHN+BjXF4xl/5JDiYOoU/+VDYvPkjbCWSKxjA7rqDx0NEKvrnr/Hy3G4PuHnnvtSlEO/0FKA5KNyzMg3+e0cn63+GR6AphF1QSckBRjhAptSU7bpFz6N+Q7Oum3bUj9LrvFCUu7q4scVUd/LC4cE2AkC3GQ9MCL+TQbrLbbpReKNzzyrBECT9IlSsm90fog7JHXexfaAp3IH4BbHU2eGwJ1ER2cT0ZVnq+phFzSZzWyhLdhUV8HHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEcICjouI4DCcLBTQcs/IADQJMqxMxAmuAAf/Ma5wm4=;
 b=GdDUMegAMvVTYHP0WWQYjZ1yumyBICIyEHcIcgTWcJzkXsajJHqHjskQA03jm2g5RODsPfsgrLGU1Pef+rmUgthOd/CMajpjApdo9oQO9zrs4HgPSiy62++IUip1GoxHzpkc/cR21ZBNBK0zxyrnbXF8vQV3ctkiWM22rwm4MRWA1B6WjuJnq44J/Kk5SnFljVHfoCZ1+0UGaiXTACa3aZme6FxcpXa9eTJWVno157BirufzPjcOqbvlUjdY9cSQgSJ8DcB8hlTskz4YGX+rkI4iaptHTj9XqNnDNp6k3zDOSi4Kg4SAbXtBokW9zROu1RXTjFRM7uhZsb3WbKPJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEcICjouI4DCcLBTQcs/IADQJMqxMxAmuAAf/Ma5wm4=;
 b=DGue092tHPsCuycdCZQcFam+X7qzL7nRWUNrB87fl6X1qc4MUONFXx9Fr1q0zvf+Jg6eg6G/oREYbzazwYyQd3x8x7S4WN6mFdfYAXBphR0zvS13fsBnM5UZqR7V6et/VTqzRcRBKC3jp6VHRp5ujh48vkmOv9uFL0emLhBqBGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:57:53 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 10:57:53 +0000
Message-ID: <47cd21ac-e679-c422-90e6-f15b8a0a7dfa@amd.com>
Date:   Tue, 16 May 2023 12:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/23] arm64: zynqmp: Sync node name address with reg
 (mailbox)
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <5d8e80383912b8ff75409764efb75f3b85917087.1683034376.git.michal.simek@amd.com>
 <20230510065835.GE11711@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230510065835.GE11711@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0183.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::13) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c4d876-6af4-49df-a335-08db55fc65e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32L3WnrIGsIM/jpu10msqQhvnxgYO/R32/p2/VOzIdIQtouZSUkVmK42E1tvDryHGUKyC1cALhoqke05JtBddmAYkjJMbGBHBLufjVPFKrUW/qnQkkZZMd1CyVMxMbc+GWuxMtXfsl2VBFUVJtJsfufxU03CqF0Upy+cCGJvM+/rrY4fhRA8C2MO75wWbP3epGBy0/fUhJ8rxwZ70cUiltTtVgd62FYiQCzSSp9XqxMH5rro05TZi1DqplfynUAftFUQMqnvEvPisKz0xkoXLkd6fHSTkixZcGL/i2M2LlOrf4/9lBEtv4sxtJMturMBe5uY+2kQO+GpJLn0AZeOolkAOs1pHU3tYLw0OTbALm5WNgg6zLI5/omcmV2JwEozQ1ytjSlveQwO9LFMYsj+4FUT+dblehvji3Vdu5giRYa5rASHWbBcgPb8oOiMqCMvACYTGgREpnaVBlFGZzdEicoFJugdF9NnfHC7xDNVJJpUO3hyrHjhq5ijvBlqSfSGEi7qJHac2Q9dZAsr3nx+tFziAg6FG2G3E73jumbPWIhbvzHqenLerWS0CtR7T8MGhZNv48BiEgq4sMuEu9Am1HG+htkEGz7oLbNjP2HE89lpj7Jo88XRsMfpTPNDj9TKw8ZXA/FCYyIzKNYqOTFgFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(5660300002)(8676002)(8936002)(7416002)(44832011)(2616005)(186003)(26005)(53546011)(6506007)(6512007)(38100700002)(54906003)(478600001)(6666004)(6486002)(31696002)(41300700001)(316002)(66556008)(66946007)(86362001)(66476007)(6916009)(4326008)(36756003)(4744005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzlLQUtWUTAxZnVqTWNBL0kvcXN6V1FtWkhNcUFsZGZSS2JoNUNRc0NyaHA3?=
 =?utf-8?B?RTdTQWxNSFdubUU4MFZJV1ZIRm15R2RWTTIvUm1QNk9KeDR1TDQ1b2RGTUhQ?=
 =?utf-8?B?NWo5Z21MaXRZUll6NWpYMFlPdDZ0N1NHTWpabWJwR1RiaHJiTUlJTitBb3ow?=
 =?utf-8?B?OHdhZmltd1Z0NjcwY2ZUTE55bmJhQjJyR1VjYlplVG9ZbUkwamFqanVaSTQ5?=
 =?utf-8?B?Z3czK1ZWbXFITzhtWW9hM1NMd016MkEzYzZsc2tHQU4yS2VMM245bFJLSk12?=
 =?utf-8?B?YlBhTElwNTJhdWZlekZyYkhGL0hDUDN4RGpMQUZlRk90dndnSEdkUks3eUhR?=
 =?utf-8?B?QlFNc25jNWRIdm8wYm5kQW9BVW9zK0VsVThCbkpnR3lLUDJXQnJzSytyelY1?=
 =?utf-8?B?ci80ZXFIU0ZtUlVJTjMyaVRtVHRnZ3MrZ1BnRVBMeWlhdHh2aUQ3S1NwMlN3?=
 =?utf-8?B?MWxQODNqeVVuRWRveXRlWHhhWmxJMWNUNnBWQlFXaDJOeEJQM3lEQVY5T1B1?=
 =?utf-8?B?RjlGeHRXd2JrakhsWVU1YUxGUHAySWJvRTg0dDBqSFVtREIzLzdiUzM3Z2JJ?=
 =?utf-8?B?RTZ3WDBWQkdtSUZrUDBrdEY4d3cwWHIxNEYxQlRCRGY4M3cxU2JuU2x4aGl6?=
 =?utf-8?B?Q0tiM0k4c2pLaXRKaXRXYlNoa29WYXhVSnpWbzdudDE0UlRQRzFGMkg3cGFm?=
 =?utf-8?B?V1pZbTRjUnN4MTBDOVhJdVF3RUNtMUFhWXMzWlVFRTVoNlRTcXp5enZnV0Jw?=
 =?utf-8?B?NWFrMVVMZlRvNDl1RU5VYnhGNHdVL1BPRnFPbVZ6TFpaRkFmNDNiS2hQejkz?=
 =?utf-8?B?OWw1UnNiMXN3NGo5aDEwem5wblRvVjBWb1V6Z3JzWkFqdldUZGtzNk1jY3dM?=
 =?utf-8?B?b0NTMlJyQy9HcElWNkQvamVFTWN3dmJraFk2MHBOWjVuRGtLU2dNNHFCVXQw?=
 =?utf-8?B?ekVNNElrR2JSRkw5S0NsaFpyUHFrU2NGeElYQ2xpNXdxVzI3bDkvUWFmVU53?=
 =?utf-8?B?VXhEWXlDZU41dllZdTdyRUlod3VLUTduczZ5bWNIS1hKeDRVK1R3bVNiekxN?=
 =?utf-8?B?ZW5peGVWNWV2NElRZkhyR0VhLzZKY2toZkNJck9iZzA3N2N2ZEVCRkVYTzVS?=
 =?utf-8?B?QkJPMU1pdzdQTTBUbGxCUFVjTitDYVRQeFRhZjczVXhCUzVQQ0QrUE5vS1lH?=
 =?utf-8?B?VFYrN2liYU9lOVZxL2RkTDBTbWxnZ0xaakRjUllsM3ZiQitYMnREdjBSZXBy?=
 =?utf-8?B?bURnWi8yWDN2dm5Rbmd4cDR2Z3hOU0lNT2NTMGJMTUtOeW04Q044eHNTR2p1?=
 =?utf-8?B?N1gzV0VvOWlwNStpOUIwVE9oeGlMSFI0OC9yYS9CYSt5WWJ4OTUyZWpHWXor?=
 =?utf-8?B?Zm5Dd2xLeGVKUElDZ0VncEcwcHk5UXpmS3pBZE5OYktLenA1QUo2OUNZOFFG?=
 =?utf-8?B?WTdkajJlaTlnNmlWTDQ5dUpQSUN0UFpCSjZqaDdpbWphVTk3VnZySlRBNnhN?=
 =?utf-8?B?Q0ZNSmhzQTZFanVTdHI4UkNLZHRiTGZpVDVOcHF6eXI1QXdyOTl5bWU2NFgw?=
 =?utf-8?B?RXVnaitTcTV6bkdYdmFoUSt4OURZZ2loU0ZpNzIvSmpKN0JkSzJNUE1wRWtj?=
 =?utf-8?B?OWMzek4rdlBiTGZHMkR3Y2JRSXlOQXpmcDJVeUMzK3ViblhsaDRDellNMGNj?=
 =?utf-8?B?a3VwclJhMnlpTnQ3ZzArYVR5aExzS0ZyQW5hL3hnUjNvajU3M2plV1VHaEFZ?=
 =?utf-8?B?MU5mYmJoTldzVCtGMnVQSnk5c3dXYmd5OFRkekhRTlpnbTVWVXhicy8yL2kr?=
 =?utf-8?B?WGg2MTVsOFo3M3l5NENkbUJlQm9peSs3VVBEdDBodE1wTkpkM3IweGo3dWFU?=
 =?utf-8?B?U2VwclpzQXdXakhyam5IM1l0alloL3Z1M2cxQVFBWDJFR0hBaFF2K3ZtVHhP?=
 =?utf-8?B?eU04YW5yZmN4RllNZWJ6TXZkTjJjRlltZHQxMGZ2alhNRmVEcWZnK1FhUnZO?=
 =?utf-8?B?cml1eUJEdnZlc214ay9rdXJzUkF5YTVXMHF0dytUUE0zS0xlZGJKdFpMdkJS?=
 =?utf-8?B?bTBqL01VN01oRmpmblN1MnVJQlhvQ2gzQkx0ZjFBVGpZdlEwZFFvTlBqVFFK?=
 =?utf-8?Q?vOjWzj1p4lD+KyqYY95EHVtde?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c4d876-6af4-49df-a335-08db55fc65e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:57:53.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0Xu9yXYq2mUaNac6IFroIWqZCnYN4FDTd5Sk+dmA5MB/pPCNnmvdux2OA9fHXJ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/23 08:58, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Tue, May 02, 2023 at 03:35:34PM +0200, Michal Simek wrote:
>> Address in node name should match with the first reg property in DT.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applied.
M
