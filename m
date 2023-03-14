Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E0B6B8683
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCNACH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCNACE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:02:04 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C1E88DA6;
        Mon, 13 Mar 2023 17:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRk0uKf4f67pVjNq0PnToILMV98tGiwxUYRULXpUaoOCKfyXGx/QS/XCcSEY4PGJ4tr0UpJ1LHYFuTWKcWeU+MGYskgJQ0jR1j7Kvj81l+7dky/Sl2GYJLP8hPfWhu5TG6DAcq8Vz4TlPs0sLeIQVSMFJotjK0pMtub0NnlewvXHj7ypH9Cg6JglsDV5EkJ/7WXFwKP2CsEars6czrPvHz7nPjXmxKL+MxASWkF1Yfu20WFovlRFeQz4mF+cCqKB4/C/YHAsb6Fl+BdEY/uX3/gZwVXxJRtefQL0JzFG/MlwHjMv+rnY19HKQO0M4UK442EbMG/8mnSHFgu7lQHoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SQEXNaIOaBMQXBKQdFaXL/BUbki1PnJlcEWNydJj1A=;
 b=FlDrnByv1e8YpfrmH0vTVw3pwDdeOlCl/1C2UaHFX633vE5YYNT3g8qvoyEuvtVhFse4DuuB1hM2Kubnfk8ZXT176aPlCwvBmUmmd6Gz38XDL/JKrILI59aEZ91/jvZG89KZt0Zm8D0/KDCki8nl7qWzP47mBkZj6O5TcUtUxM5mk/GYmyKI4+wY0cG/2xdtVrkvSnX31ihxia8i8eOqZBOFt6fM8GFuJ87l5X/jc0fioKjhX27ivl6c9B2n5G48FmA7fnJgxz5xAzID1pnqHb/2a1mE1Kqk6sVlT7+G3bVd9Uz2tMaGuXauAFbIX+cT3FUay/tcyQYV/x/cpRjgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SQEXNaIOaBMQXBKQdFaXL/BUbki1PnJlcEWNydJj1A=;
 b=KSnFy8gETuBV7OnkLI8oHI2vpzx2TKSB5uixk2RTBtlBHF5sS8j+rh2/rJOPM8LVRLFcKi2KgAUXA7zyG9HBqiqUvRFNI67sdFlcLgjxKlfr7GMh4OpPk/c0IcDv7s/nvqreaGdfPHs5irSxyOPSm5SeKRyoq6/8G4tpOmq3pFBUwJOltzyCjdp92762y70P4yGb8fulhruzIoyLq+YsCbwv95mWGrnjZkp6s7s+sgAFBHGklF9fWC0owEDhJwJ5fTLHbV+iFMdr6ryKqQzTclJRh5HogJAmvIALkaPh0/23jyZSayiAZY1PpBV8r75eqCpZjoEUYqaMsPGB2OgD4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 00:02:00 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%6]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 00:02:00 +0000
Message-ID: <bceedc91-cccd-258a-1cab-57a79f5a294d@nvidia.com>
Date:   Mon, 13 Mar 2023 17:01:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
Content-Language: en-US
From:   Dipen Patel <dipenp@nvidia.com>
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
 <798dd219-f4aa-39b3-2368-7a6d072b6de2@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <798dd219-f4aa-39b3-2368-7a6d072b6de2@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 3394760c-94e0-44bb-fa58-08db241f5554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRtAUlnl62xiR4JYBftH3QA0klEfMLwldW2TSv6BCQnb0pRfYobVyyz6esj4tXZPpAvA3+427WRtrgV1aNaGd2UnVmNhY8fkSOKonWdGqob0uW/ZLN/M4BL7m1VD2J//rtxK7FYo77v3VnUIyvuTWwQla5D8Z1GdV8KWML7ENbcCQ6yFaZBMlDKiUTpUKx1cDJiLaZe6+VGzOqW6PQg9hertEVXNWTJ4w4pvcrRjNshRCYdPvjlxJ1xc5t5kX9tTp4+7dPaYYqGQHZfw0tKwveWoqCm0va7oCXXMJKAIZNTq9NxPCz8/w1Eul4IabCHcqcB0M94g7YgMGteDpmRpgPK4DhKujg/kp5RzQ1z2cEyHQLhqo1+1+pZbc+eUEyRo96hJqNozDN7d8z9rANgtDhWgWh5gLEOBxH3TmgfG1EaqUSZOsOVDzBdtj5Co8LpHO7PnqiI/nrCgIxwwXCG5J6vhaBKN4bVPVcsRNc44UsvzxHlLSnv5fMabjUGkDh0hM9MXq/Ebwd8haZKlU8mu0rnW23MUT76x/nDIFeo3XNlhJptaYgzGI1i8GxlZkGH+SQIajRtD9cAEb5IMbLhVjORG6Hhci6qywkkfjqIpFFNSFUyg0NO1R+JVoPngOAVxcDN+Vb96vsn3MkIRB1jIXdPXNH2nRaLQYoXC9tyX/C0jFJmRsj5IeHcVkGLnC7oYUBhTE9Z8OZCGCMBmk0G+Tv4nhb73JAtvrlfyBlH+r+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(2906002)(8936002)(31686004)(41300700001)(66946007)(6916009)(8676002)(4326008)(5660300002)(4744005)(66476007)(66556008)(7416002)(316002)(478600001)(83380400001)(6512007)(6486002)(36756003)(6506007)(186003)(26005)(53546011)(6666004)(2616005)(31696002)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZRanU2UFloVGMyZmJ0dDBkUldySmg0TTNjTkJCRDRNMnprVDYraTVxNERM?=
 =?utf-8?B?VEtCYXBlOTFqTndZdlZLb3JLRW9aMHZUQzJmYVVWcXM1QnpWU0VFSDg0Y1U0?=
 =?utf-8?B?SEZOL3l3STBQS2RXMmtTZVhuWEFrSGh2ODIyd3ZLTVhUSmdCR1JDdHBHWURQ?=
 =?utf-8?B?RmM3RzlFT3JoY2VmKytnU1RFMDB6VU4xZ1VWUDE3RFNQdEVYS2dZUHYwZ3RR?=
 =?utf-8?B?TmIvVzZLa2JJaXYzKzAzS0k4WDhuWi9JYTBya2Zyby93SDVMaG1LZmUzbW9O?=
 =?utf-8?B?Mk1tRGsvNjNkdFZFdW9rUXBnUzFzVCtKMlRDZHB0cnovUGtzWTZaTktqK01D?=
 =?utf-8?B?SDFSRFNHNC8zSEVtZENQc09lTHR1RTA5VTFHRytBbm96dXQ2Q1hzenNXMnBk?=
 =?utf-8?B?SWxQUkprd2x5Wk43NEZZa0dPM1BZbW1EV24yS2NZMC91Z1QxV3NXRWlyK2Nr?=
 =?utf-8?B?bTJwU1BGK1NINnBJZ3Q3YkVBUFV6MldQUERBMEFGc3FuaVlkdVo0MG9wWXZi?=
 =?utf-8?B?UnQ0dVZmN3dYRENRN1hLUDN0YlMxNHUwQTdmK1VUNkZ0M0NIbTdxd3VOY3lT?=
 =?utf-8?B?YXZjT2RKc1JWekxFTlA2aDJ1WUVDYzdrYXlDWDVPYW5SZUtrR0JSMDdxR1RE?=
 =?utf-8?B?Uy9wc1hKTnVvZXFXdGJ1a1ZoRWNxNEFsR3lUNGNmOU00SVNCKy9LZDFOUmx1?=
 =?utf-8?B?SjBjSFdjazdBd3Y5TkNyNXNnc0RKYnErMjNYRldlbUdCbHQwaGtmeU9rVjRZ?=
 =?utf-8?B?SldlMW13a1oxYW1VR0t2YkVQRzZKRUtYczJjN0dNWnNyaWlNbUlHSFh5LzE1?=
 =?utf-8?B?RXVZOHlYVXF3My8ySmtPRElDaENOOGozODhiLzRQQmlQVzFBMXlRNWNTekRr?=
 =?utf-8?B?ZHFLUnZibGFMdVhWSU9mOVpTemIwbWExdjdmRnhNRkl0SFdSS3NwOW5YSEFs?=
 =?utf-8?B?V1VENXpFcE5jY2MrRkkvL2pIRDRVUHFYMU9WZmlRSDJYNHg2cS9rUGlqdGNB?=
 =?utf-8?B?aTVTWjhzRjd4aFhqZlo4dU9DU1REcy9zQ2xwcnFsZHVwcm9pNGgwR0lNS1VQ?=
 =?utf-8?B?eUZNNVZocERmUmR3UnVMOGZmdnEyTHh4ZE83WlFSUlU2WTE3UDZOMTd0Y3pv?=
 =?utf-8?B?L3lkWm5lR2dRM05EK0VBU1kxNVY2Sm40KzBQUUJHc2Z3Qm1VNlVSMkpaNEM2?=
 =?utf-8?B?STRrNkVYZGtTcTc1a1VERmVDUHhRNWlFVlJmTlFoUURtbVl5c05aRGFFRnBl?=
 =?utf-8?B?eWtiQ0lBOHJsanhNLzdhZklsUlpEclFZeUlRNERvMVY5MWJGeFZMZHIwM09O?=
 =?utf-8?B?MUhmR3d1ZFRwdGtXNTdIaThVNmlGRjJYbndEcGhvTWFZeWVtNnZ3WTZXeWk4?=
 =?utf-8?B?dU9LQjJsZnR5WG5FTzJqZnh6dmVKMmIxU1hCNC9DbjU0M29RVDFzMEw4UStZ?=
 =?utf-8?B?Z2Jwb014aE14ckhOQ092MU9YNlhNZE54cHp2THFjckp3a0h4eGtsSzNWMW0r?=
 =?utf-8?B?cUdHK1hmbm9hSERWOWJzNko4UGR6elBTVC9GZ0ZSQTRPNVhrYlBPN0sreStt?=
 =?utf-8?B?dThnNzNJRS9LbTNXdTFhS3hia2dOemVOOEdGOXV2MS9WWCs2Y2NHSTduUW9z?=
 =?utf-8?B?dVdMY1NDamRCVlIrOGRIOERjcnlWOVFsRVN4N0JsNE9nRy9pbk40NUQ4cmdp?=
 =?utf-8?B?WUxhVStCdDlSdzRrWnF5a1BnaC9QcXFpUkVkUU5rMVZXSkpvTXUwZ3lNYU5I?=
 =?utf-8?B?WkNFY2t5Q0x6aDhEc3BkcVNRRkQ3UGlZc0czSm5LRTB4WkJkZjVraHE5MUl0?=
 =?utf-8?B?OFZ4SWZwc3BhRDFLY3I5ZmtkSFhtNTM0VGkxWGFqd0hWNlpIM2xuTUZKVHY0?=
 =?utf-8?B?bTI4Sml6WEpaUkZXd2ZhdHBvelJZS1BJWTcvOXRTbUhpYXdSaWQzUmZQTzdE?=
 =?utf-8?B?N0tBam8wanVlYlpZR3duWkUwenN4bWlqUGNQVmlTd1UzRWx3OXlseS9ZR1dk?=
 =?utf-8?B?eVowK1VqUlRYQzNDalVGR3NLMU5PVDFuMy9NSjd6c3Z4TmpoOVJ4UU8zWkpy?=
 =?utf-8?B?NDhGdjJiZGJPbXhwamJQeDNZYngxZE1vajBMc1ViaUwzZ2tOdHIvRVVibDU3?=
 =?utf-8?Q?HLh/7Ml7jc+znJs8a8m3J8LAh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3394760c-94e0-44bb-fa58-08db241f5554
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 00:01:59.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B86fkyr4sgp18dzk9459ZG9js4H89T+dN/8sS72rbSTYsItwzuB6KGRWuuhwbDI5suBnhA9IsQzP3CL+PQE3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 4:49 PM, Dipen Patel wrote:
> On 3/13/23 2:57 PM, Linus Walleij wrote:
>> Hi Dipen,
>>
>> thanks for maintaining HTE!
>>
>> On Fri, Mar 10, 2023 at 8:06 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>>> -  nvidia,slices:
>>> -     $ref: /schemas/types.yaml#/definitions/uint32
>>
>> I would not delete this, just mark it deprecated.
>>
>> nvidia,slices:
>>     $ref: /schemas/types.yaml#/definitions/uint32
>>     deprecated: true
>>
>> (And remove it from required, of course)
>>
>> This way you do not need to explain about why it was
>> deleted, it's just deprecated, which is fine.
> 
> Great suggestion, thanks, will make changes in the next patch.

However, as I understood, current point of contention/discussion is addition of the
nvidia,gpio-controller property.

>>
>> Yours,
>> Linus Walleij
> 

