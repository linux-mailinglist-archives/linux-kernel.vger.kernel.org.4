Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E858746788
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGDCYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDCYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:24:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E88E6B;
        Mon,  3 Jul 2023 19:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv1+6QoGeHmKHmqa8+VleQof5TYKCEP4vGOJrqOmKxwXTAvkVqmd4BgoJadHDHG6+WX1Dl7B/mMEv+JA7szjfCU42SYh7Z8g5XYYsEns/bEaM4M/3NBHUM+quD7vtiQTy78y4ni0lx7dMHTotVm3o5yF0MNU+9mGVklJbh++VInVUIbjRBEesqm85EvDKE9n4gY9OTnstWEzTYRCi1odXr5ZPqMVhOyfI1aV6+eKJtCRzRe66PpLzn+Oodl7eshJuC6GfZTYlqMmmxCJ6IvBc6/IEDSx0tfyYPq5YohXQpc9Dt3pFwyxFrSoGNuvbqwP84sN3o2yLDXhcylXk1fouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYJ1PV5HU/Po9tnHIWn02VUP/IWa4s+8Dd09ACHnliI=;
 b=V4qLXx6M4xI50fZHjl5QJ+CF1zIbWe8pJTMbw3va6WCDIzfUMgyYTB5ILGailAONLrLk9rP71SeS32FHVfHro17ozt2ADJBgXN2dV4G8aVficaqm9WgApq77mPv07sFbKBTB6PjU8fmNtg9p7LNjqMoqt1fQI0E8ljUuy2s+60UUDH2/frfJiOnbBxnLyZy5Tp3gUyIUpkMyEIMtnWvbvSo1XNBV+Cjy5KpfcuEKDipw7iFzN/HROBGYbFr8CHGzExY3yoLVS8+I/dJS1JAmLosPltL7AHRWuxXtibY5uRYPWVsGr182Ntdhu2cieOoFGxPK6vJJVqlCM9QzSw+wAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYJ1PV5HU/Po9tnHIWn02VUP/IWa4s+8Dd09ACHnliI=;
 b=DYNKFrrs32fNNeb3DgUJMC3wYuA5VM8Cz3kDAExDxfOkxMU/6q5+Kea38gYdKeXaiM9Qqo7uZlLSg3HchR3SUdPBvLfghIC8Noh59/E/jqsuY+gIOht6Al6NXfaDM/BUacvzMaUOPriwDCFdfjG6bvP/ceb45nqn5zVCXNgOO/ywM3oCKkOVBH2iB+Z1AjkNcZolpGbMZnH9qgW4t00jlYZYZDB50H/3CbZ7hGFaFC9kveB5OpX75+0iB/Ipg+AbxQMZaGhWydNsEE7DW5ziJ4HqdO0a7GaaIMj0LgafkmIyb7d4fSWpRec8yo0rq4Y51IWVxDg2/JzsTfthTnVNfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY0PR03MB6242.apcprd03.prod.outlook.com (2603:1096:400:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:23:21 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:23:21 +0000
Message-ID: <4774639c-d4f1-0b7d-1ebc-578e957b9f69@amlogic.com>
Date:   Tue, 4 Jul 2023 10:23:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: add support for C3 power domain
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
 <20230703093142.2028500-4-xianwei.zhao@amlogic.com>
 <992f74b3-373c-14d2-12cc-85ada068d54b@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <992f74b3-373c-14d2-12cc-85ada068d54b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY0PR03MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: cd572a9a-b1e6-43f7-92b9-08db7c35a2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLXuPPjTaDw21KG1Z6hQphhiQeP0MJoiQEBPHlOdB3z9mDki3xdV848U4s5dmHAN7Co3Tq0Z8SX16uNDhMwpdeWvWdaPWbrk3dygQbGPoTvip6xYJhvTMkWidz2np+/SEfIfQbbH4W4saoQSV0tVGQmuKL/eXushV5h6dfb5W1riWV2EXfJgXu3ATSHLi/lWIiWQu1Gjpq7xbsz3LH8kxfw0G1mK4IWxQstZ/WSToj/4e+13aEqosg2vaYsj4Rt2cV8FZc2UqYNLugG/lCFY0/xdjSwN0DHE/FBM63tmAPccP0pXReh8ZhnTCfYJdWlvpY+fqG9Yt46PSVXq/y9VjpqYoKZBt/ZRk8uetYB9fr+WCWG0BcXv1BITEzCwy+xriIMSmW7WoSd8qpMZO94+4w18Dg129Olrt7QzFuGoPR7zZVNdVO/ewVtBjI5yiRuRFa1YeOmoqV6/dEj0ZRaxs1PaH7bqgBC+nUg8Ce9QCRU/iV1OEqMuXHHcNqOB9k6Uius+1YGGwWb22pa1jDJM7pvSELzxCUdE2+jVchspAv8W4BrhTaRsJM7pu/aVXXoWYWR4bpHQK2vIkLkvj0ycxQBmdqNqJczIQbefcRGjb22lUlS8mzQ5aaUMG0o+qxcL0RSIkTaVBJceODab336cyMb6/jEpwiVOuBDLIXL634BsFtgEBZl1XHIJbJBT0P74iiYqS171n16Rwod38c0bRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(366004)(396003)(376002)(136003)(451199021)(31696002)(41300700001)(86362001)(38100700002)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(53546011)(26005)(6512007)(54906003)(478600001)(2906002)(316002)(36756003)(66476007)(4326008)(66946007)(66556008)(8936002)(8676002)(31686004)(44832011)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWszaFY2cEhVNXQzaTRERWROZUU5ODFDQUNoT0crb0t2Z2k1K3lvOGN1ODlK?=
 =?utf-8?B?YkNQN25mVDJIUVJoSEE5d0hOa2FqN0I0QjFqNUFwQU5qeGt4aXAxMS8rSFU5?=
 =?utf-8?B?SU9pQVpqeC83N1hHWWF5ZVFDMjJQaHQ3VmlTdGZBdFVRNitoRi8zK0dZK3Fx?=
 =?utf-8?B?NXhsWjNTZndScVg1OC9CVnVOTjY0TW1xbVFyUldmV1JBUXUyTFk5dmJxVmJH?=
 =?utf-8?B?ZUZIQWt2dGFjSnRFWGNZd2dYTU1vOEZMRU0vMnRlWTdvN1kvM3J3YWovTnlp?=
 =?utf-8?B?bGxCM2lUcWp1L3hKUXI0Q205MEZnQmRseFhvdVpwUk91UEZKSHc0Rm92ais0?=
 =?utf-8?B?V2NwNTErQVgvR0o2TGRCdm9jcTBQSHNENGw4aTRxTjc2aFdEbW5zRlpFUkl0?=
 =?utf-8?B?ZENpT0tmU3I4YWpuN2tMYk1IRTVselRPdXE1SDAvZW91cE9lR1JZSEdjZDhi?=
 =?utf-8?B?S2ducG5rR2NhVHNPTnFVUmFxYTBMNGkwbi9uYXVzM0twMjNCRWxiNksyQVV0?=
 =?utf-8?B?MGl3QXFncWtLNmJHUGNWVlBSMy82QThaaVFZQ09NL3hRN3VacjB5ZEp6QWYx?=
 =?utf-8?B?MjJPY1AwdGowTFdNbTF3a0Yrb2pvYk1GRHFKQmJzRUdKTjlVSkFrN3czZHBz?=
 =?utf-8?B?RkxwQ1ppMjUwY3pKY29nckZCWS93Q3o5S3B4ZElBaDg4bVlFcFpqVUQwaS9m?=
 =?utf-8?B?VEM0QnVrQlVoTnp6MUE2YVRuS21Uei90OG5vc202U015WC9sV05hWFNqZmtT?=
 =?utf-8?B?NDV4bDBzclpFZU9mV0tuUkJyQWNjaEgrUGIvZE1ZbXVvODdkRUtMb2VFODdM?=
 =?utf-8?B?Snd0NEswcWwreWxjS1FNdzhUa3R2OGRzK1RkaWc1dVlhdnV5NWVCSUt2amI5?=
 =?utf-8?B?THdQbk56SzRtenc4NzIycVVPbms0eFBGQm5lRHQxZGxSc0pEdFVzeFhabjlN?=
 =?utf-8?B?UHFEODd5NU5TSnVMQXdMaFFBblVDSER3d1htNk4yaVRBM3dHblFrNUZYYVly?=
 =?utf-8?B?aXM1Sm1CcUpXUVJnOWIwaUNXaktlQlFZUGl1R1daclIyd2dscy9uMTQ4dThr?=
 =?utf-8?B?L0hoSWhyak5LekhhUVNKMmpmeTJNVlQzcWhyQ0J2TWRsU3d0SkFXMTRLRlVp?=
 =?utf-8?B?aU9iMTQ1K1NrcTcrQnZQRElDUy8xMXJIQVVtUTZwQTl5RDU0aTVpdmtWMDRZ?=
 =?utf-8?B?TFhaQTNKRDZyQWRlMitnaGJvamN4MC9sL1ZKaGI0bFI0a0ttOEFtcWRRa0t3?=
 =?utf-8?B?RWpLN2hvQzg5bWwraytXMGhrTUQzdm9HNXM1Ny9ZTWJGQ2xyNnRvWFNWVm9M?=
 =?utf-8?B?Q0Zhc2N4Y3RtekpSVzhKM3JURjZrZXhtWGZrNTN0cUxOSGN5S1l1VkEwa2VP?=
 =?utf-8?B?Z1BLSVhkMUY5SFNUZ1FjRks1bE5CSVBMN0FSNnpPR0c1SUNpL3Joc3BsOWFB?=
 =?utf-8?B?VTBlV0w2dTdDempmZFpVNmUwYS9Jczg3d043UGRHc2RsdncvazRFaXhleXlT?=
 =?utf-8?B?MkhSaENmVDV2U3NmMHRkbVRROFNWVWtvWEJlWjcwdjMrVUNIVTNaM2hhMnNJ?=
 =?utf-8?B?OWsxNnBhN3BqbnFWYkVxaDUvYkNTNkJ3dzNRRncvODE0aW5Jd0tzS3pjTy9T?=
 =?utf-8?B?WnF3SzFRUlVZM0s2OTBaZzFMb2U3UUs5VC9HVHFTeVpDUk5sTFY1b1c4dndU?=
 =?utf-8?B?SVQvcFZ6MVJTRG12UnBSQ25pT29BSWdNaWJjN05XSmViclNQNEtuZmRsblNo?=
 =?utf-8?B?SWY0YTA1SzE2MURYS3d0N1JuQnNVK0ZCRWdockU0V1g5QVlkOFFZTUJVN0tv?=
 =?utf-8?B?amtMVlU1bTVxYzdvZDJzYXk2M1NNV0djWlZwWHBYNGsxZ0FWdjJtei9tNlZ1?=
 =?utf-8?B?VVlQZFBpejBBSXRHRnRPVGFMc2REOUUxTElNc3VtZC9iMGFqTFNNeUp0Tm9u?=
 =?utf-8?B?aTN3cHQyT3R4K3hMM3NGQU9UcXNWelpZUTZETnQ5OGNRRXh0UEZCV2xjanps?=
 =?utf-8?B?MzBIMXVJV3RYKy9KamF0U2tiU21kNklNdGk1L2d0aHVuZnRYdlA2bkZ0dmx6?=
 =?utf-8?B?Sll3UWFWVXZteVVHSEsvd1J2UGJjTzFkU2ZmbWpHZTVTVVNDNCtXcDdxb1A0?=
 =?utf-8?B?S2VpQ3E2enZRUElVblZNTmQ1WVpyNmVCZUwwOFNYbyt0d3M0Q0gwZEZlZHds?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd572a9a-b1e6-43f7-92b9-08db7c35a2f4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:23:21.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EA4zJdJbeqhZegLh8av8+Ca679GFAedzmJ9ZOaYLpHfAw3UHxpHZjiFnPBR36/bjoRK+WLGSP/2QHMShO0nrAA5/2+ZWbpReW7ABQ1aiVc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6242
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
    Thanks for your reply.

On 2023/7/3 21:12, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 03/07/2023 11:31, =Xianwei Zhao wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Enable power domain controller for Amlogic C3 SoC
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> index 60ad4f3eef9d..826c51b1aff6 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> @@ -47,6 +47,16 @@ xtal: xtal-clk {
>>                #clock-cells = <0>;
>>        };
>>
>> +     sm: secure-monitor {
>> +             compatible = "amlogic,meson-gxbb-sm";
>> +
>> +             pwrc: power-controller {
>> +                     compatible = "amlogic,c3-pwrc";
>> +                     #power-domain-cells = <1>;
>> +                     status = "okay";
> 
> Why do you need it? okay is by default.Will move "status" in next version.
> 
> Best regards,
> Krzysztof
> 
