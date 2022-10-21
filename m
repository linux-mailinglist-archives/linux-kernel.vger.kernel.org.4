Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9798B6070D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJUHTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUHT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:19:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769163A3;
        Fri, 21 Oct 2022 00:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZmSiVDmYxBmfjnJLmu6kZFmr1w4ThMMpsJt2K5WH55AFEGjD7MD+9ywSR4N+QTkbEVIemB+FwxXl11JcClOpLam5ni5rx72sBnMGmIRA4GRwv95rEE95Fmkpb3j9IM4fRjAehQ96wmHFocEXpt0KbOPp4qZPLMi38w2QHKSP/X9ewlHGJOBki+VgHmzXrd6/s4o8EtFr8RC0vHfAw1n+zind9STPkGpPP8/RKZwFy82gO2HLSVhL+lrvRmCYkMwAEvVdje2yxwbB7AwNU6LgcZfYEDLidpc7N8s8viJLNB59v/7p/nhdPO+rLNWqxV6+RXgY8pvV4aOxaJkF5sCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5O+LhLqSamTheG/SPoeoiKLE1/Op/vl6wybSZfaLjw=;
 b=bGXj/cLzRm/QJu5qy2rw0P1zsPIlv85M1YM4qGdBs/SS8V6nqayl9C1HN0Q+k9iwmNloFrjAs5neCdgH8c6bI6YYFyQvT9mV8EKcY0tC3UcHtLCS9FRFDZ5bsi2AUNjXoCRgDwZkPIR6LXKRNslMPRhlKzb4Q3DQ9iVx5p/TjGXe0+koxyUsikxONU23rNvWGT3hoihhUNMcFCQO/bx0lnfrkqg8X873w5Ygtl4g116STDeGYVxN0wloc2gVNRQLamx4apXj6XSYoSOGNKIagkXdEQPnq3cRwv351wmpOXGhpqCeya0ohyioqgrhCxVx2DtIzyQssIWklgrqn1sWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5O+LhLqSamTheG/SPoeoiKLE1/Op/vl6wybSZfaLjw=;
 b=i5CTqUa7Lbfn7/KlAYNiDQCe5gWUxJExCiQ5y1yPjGjvo8WiJSE+pQMkW8tpYVa3rfl8EBY6Ai7VpDacZiC0rAzlPmz4QwpdBOFaZ3syV3Mauq5TylMRwUcBHrb/90ZGpo+ndBC6PtGVv//RghLkGDdo95AAWwXtFH8swAieqCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:155::18)
 by PR3P193MB0618.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 21 Oct
 2022 07:19:18 +0000
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::a859:9fdb:38b7:b0f8]) by VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::a859:9fdb:38b7:b0f8%3]) with mapi id 15.20.5723.036; Fri, 21 Oct 2022
 07:19:18 +0000
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 02/17] ARM: cns3xxx: remove entire platform
References: <20221019144119.3848027-1-arnd@kernel.org>
        <20221019150410.3851944-1-arnd@kernel.org>
        <20221019150410.3851944-2-arnd@kernel.org>
Date:   Fri, 21 Oct 2022 09:19:17 +0200
In-Reply-To: <20221019150410.3851944-2-arnd@kernel.org> (Arnd Bergmann's
        message of "Wed, 19 Oct 2022 17:03:24 +0200")
Message-ID: <m38rl9bq4q.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:155::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0685:EE_|PR3P193MB0618:EE_
X-MS-Office365-Filtering-Correlation-Id: c92c81e0-6257-4cc1-a0d2-08dab3349165
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJW8Pffwv8OLc81/dywPFsVVvLzpRSjRMUyLVnwjPFepsKzQ9RD+sZjOTfChXnwBEuJhsFsFYOSo/QMFwjKcScNo+xEhM6jt5fJ4VeUSX8XqDEXJKXBJoTq0rclKCO96JMHc4gfRmrzYC6LlVgDC0Pr5PdQojVOmJRCzmi7+lTZGsI/ajmCkLwR1R4B4tNhN1vP7sd5zUW8z6PNM0yACL8U2ouZ+SU1n5VBnJRrr9GCFxTzqMsDQk3P7m0rIKn1+65nZUhIdirmOya1ufo7KLGVKTOjhO2JOxqStYgVZd2VBMP8XlCeELqzx7Uftkc0JvwGV3TgrMcn/FnVEW7w5kuP85qhkiieOcwhkZSR7BrLTigic8USag/aRb9mJBBztzO9n1uO2BQ8SWsuxSEW7LHqpP9MeJnfnquhCMA00nnsa0sE4STb8eNlcfqq+5OD5X7wSuJRvwB4EILhAmUWUsQv5RxJ8twvwCr+UqcNtE+jXoLpTdQ8SVBM1tMyIIIk44LuquPZ3co5OIIiRJIEBdVIRmPRtjTptFwk/XZyHJBxtGR0IC3jqKDKF9TSL7Xjh4aPEvAr3Q+L5+q7sjsdPuLckwyBD7sWqymeo5nv7EeCiciWzXZQho4m9fIc/jluKSXwaNI71EbRrE0WR3IpgBTG9Nw1+rA3K3lIZK1H2JtznK/122XKSkEWIWOsZGyeD3gZ0duatlh75MhIDCHRkLNr0qYMH8X1wl/LsLcpxf9Fzz7NeGuN0WgycPmvOIOSpDVWVYBOTCkPS810hrcjpizmO1UVQyiH2LkePFueWG4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0685.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39850400004)(366004)(346002)(451199015)(6486002)(8936002)(83170400001)(38350700002)(478600001)(38100700002)(4326008)(8676002)(786003)(6916009)(316002)(66946007)(66556008)(66476007)(52116002)(6506007)(5660300002)(2906002)(186003)(41300700001)(6512007)(26005)(4744005)(42882007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjQxV20raWgzZTFUUTZ0ditnUkFYSFdjdmZjb0xUbzFsNGdYK2NYOUlTbkhO?=
 =?utf-8?B?ZUI3WGppMkFFdDNicVljYWFJaWl6MVBTMjVRTG1BNy81Mmt4MDd6S3BMR3FS?=
 =?utf-8?B?VUw1RU5ndzc2YWNJOUJNNEMvYWJXSmlqdkxsQWxVTDZmSWs2ZVJWazI3N0Rs?=
 =?utf-8?B?UmJPeHBBdkVsd2NsSmpqZ1ZQVUhxVEF4QUhLOHRRdjV2RmJGVTlUWHpBa3Ew?=
 =?utf-8?B?TTZ3RjV6R3o4Q3lHZGdJdWFBL3ludTZGWVpnd083T1hmVnNtOE1QMDNQN1hW?=
 =?utf-8?B?STNoZmNrMXBBNE0wUUt5YzJ6eElmLy9XaVRwanIxbG11RHZZdHpZcEs4RG1r?=
 =?utf-8?B?eFVrZFUyaVZqbEhzSXYyVUExdGMvUkpBck1STlkyZm5reTZwbWczbzhyNEkz?=
 =?utf-8?B?VUlCSzZGVWpZOGljWUF2RkUxZm9qaHhqYUFQaExPK2VvcFpqZGdNcDlFa2hQ?=
 =?utf-8?B?em04S2F0Mktnc1U4eGt5dmF5ei8vZmxWS2RneTNvS0wrRmFmc3dBY29FU3p4?=
 =?utf-8?B?QjliVGhNZDcyUWs1aGNPaEs3MjNMaFJqaHRFRjBQcHZYT2pDMWpQR3JMMDNk?=
 =?utf-8?B?V1JyOW5mVEdzVnJydVFMMksyeUd4OEE2RGMwNUFhSG92SVBVNHY1eGNobTJ1?=
 =?utf-8?B?bTFNMUs5djhiRGpDaHprRzVoN0ZvK1FWV1J3NXQzdjNqa3VGRHAwSjdnSlYv?=
 =?utf-8?B?U0tsaUhyNWdKV0phVENTYkZkbHRxbDN0YlhqQ0p2RlhPYzJLMFRBcjhldEZQ?=
 =?utf-8?B?MTh3VFpDUklPMWhNdjBzL1d0RXNDUWhUb2l0Ulk4Tyt1NExUbzAwdER1bmZu?=
 =?utf-8?B?UlRUR3BUclA2dkhkM1JPUGNnR29SU2hUczhpSCs0UWJFU0xlandTaGVZc3Rw?=
 =?utf-8?B?M09sU2ZkdkZVUjhUV1RFUjZwMkFxUTZ5c2YxU2lCT3pvblBWcDc5ek5HVUFj?=
 =?utf-8?B?a0R0ZzA3VUZtbm8zUHFqMllBRFRmWVJyRW0zVFFsME1waHlWV05BUG03UFAx?=
 =?utf-8?B?b2prZFRpYWRCaThLcEdreE12YmRQa2w3T0dSMmNJazhyaXJZN3dOZDQ4MGpL?=
 =?utf-8?B?alNIY1VxbzBtVFVNU05xSm80cWpMWEh5ejBpOUpHUVczL2NWd0pGMFh6UWFE?=
 =?utf-8?B?Tmxqa0pjcmFxRnR4NHc5QUw2Z3ZveEtKQW9HRE5Jd3BxWno0WXp2aEFjeFpn?=
 =?utf-8?B?OWIrcWVIVTU1TjFDTitJQlY2eUY1WGJvaEpTTTRzaWFOeXJ1eURBV2dwaG1I?=
 =?utf-8?B?UVNoaGlxYndRd0xrV3dtNmw1WWNLdTVaOFI1YTV6V0hJNHhHblVmTEkzTTE2?=
 =?utf-8?B?Z0JnOURGcTVESFAwZzRPakY5VE9LUXRDUmpsc0Jkdldkd0JEbTBZaXdRRHpQ?=
 =?utf-8?B?ZStwSTYwWVh6Nm1wd0hYeXN6Y2VWQ09wS2JGb1k4OVZ1ZjViZ0tBMHpwM3A4?=
 =?utf-8?B?ZTd6eS9hNzlMSGlJU2dtMDh5aVM4OTcyVWVXWCsvMFQxN0JENk5JMkx1V1dt?=
 =?utf-8?B?bHlwbXREcklONVBFY0ptWnZhUE1DeDJZbUlwczRwOVB1aUVOeEFWQ2tpTDVN?=
 =?utf-8?B?bmVGZnB3Tkp6WnlvbENKaXcwc2NMNlpBUnVkSnV3ckRjZ0NhN2pwU2JqS1Rh?=
 =?utf-8?B?SjJqUyttMEZPNGtMRzI0enBiOE9Uc3N0TXRRSWlXb3dhc2pvOFFaRFMvL3pz?=
 =?utf-8?B?Y1JjdGFVMUxBZi9zNzViWkN5K1lrVWFINm8yUjFua051WGtqZEgyallUVW5y?=
 =?utf-8?B?UHdkWkpFUmROSmZVVFBIczBHVUVSL3FJZFNoYXQ1VG96ekhPSk92ZFNrTXVO?=
 =?utf-8?B?dU5wZVJCNUQ5cVBicG92MGw4RUdnYng2U0JZcnhWWEt3SDNzcmllcXlRb1U3?=
 =?utf-8?B?WG5Sb3lMQStlR04rWVpTdU8zU3N1UVV3VmM3eDkzR3ZDTmYwa0d3cjc5Mi9B?=
 =?utf-8?B?alFpMkJISmdTeDlLS0JBZUdCSzdFRVNlMzU5dm8yWHdpMThsV2s2Q1ZmWUtN?=
 =?utf-8?B?cVhOdHhqQmdRNWIzMVY0TFpWVDBCZmVkL0oxeWpWL0s5OHhUdURVRisxNE1a?=
 =?utf-8?B?T2JMSDBzenM1L0crQnZET0N5L3JZU2Q4bDlrRDBXblBWWDQ0Ky9NS3pQQjNN?=
 =?utf-8?B?QVdhS1BIODFwOVBiYVRnNmhVY3RPczdYdFdJWTdhdDJqZUZTY2c3MXZKVHBz?=
 =?utf-8?Q?KZPpeGj2jQc4WVAaHZxh1u2YaWm4jNppDcU5oUeh3Ig9?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: c92c81e0-6257-4cc1-a0d2-08dab3349165
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:19:18.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HzDf8XBK9ryr17gzOJTEKPuQMUAEFruYZQQKM22mrttWlQgnmVZKlob/3Jw9602XJQqM3yWRfjuYSIjAfQ+XZOFhi4nCHA1GUAIZYbOWmw0kXT6Vgm+QtB25BiN11AwZUFj25zQUHHpgSp2a2xcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0618
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> cns3xxx was marked as unused a while ago, and gets removed
> entirely now.

Acked-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
