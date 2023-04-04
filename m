Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE86D585D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjDDGCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjDDGCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:02:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB272689;
        Mon,  3 Apr 2023 23:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RujFcCWM7x+AvTOlKL82LSZJgVZ1fVAS2X6reuqNYmnw61f93W6LxbgCxaK5WMZuHz8fVm0PF+H5luY0GN35YkHa9NQyzfDGlIS43lzVJqKKmQOng++7ElbbVZ8+QVwvYpWhggf93TikO3RtcAorkkrcDoB6YF54/bjab7GSvRwGesh620KkVzc2kabszD6oQul2D0CjjOD1t073SbZhvyZ6HHIenoxYqy6XQ46V436cUnpZhabdSMzs79ErU4qVtMvGTS6/9xzSoeqyB+5XcUeeIceEklFjXpIQorP74whBSX6MQsXN6Pg37nG9uYGHqWXFQEx7ON9F+mMlmmFeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG4JT7wRXq5pm92oHcu4WEBHrtOfRw3Ha1wSnwh8J3U=;
 b=B6Z8hAlDjNr8A6xXS/Nxj3vQY+QXn01/0SnFeUhn/GMVyPj++jr2ZzssjBi6rF0BGEUBZbw9vqT1BNjlKhBbBLkZV/RxIEasD1ebt7yqSxArrvGSFYa6n3ijntxi8mMpXXi8N//L/tP2o2VLXyAMvMnKz87g1EJ7bI5UUXaGmxmqib1e8BytJ39HyHC6fymw7BCJv28knkYegRNl1jRqQ4uvlfqg3yryILXk9kwO4KzJ9nZEqgJgqEQOK66yWO7LNfMTI1SDKZNVTiQECUIHrFYPih5xwaYSdZq3wtE6kBbmmPiSlcMzaEk/LRZ5eE/fIA4we+bVxyAnWY7I1VMrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG4JT7wRXq5pm92oHcu4WEBHrtOfRw3Ha1wSnwh8J3U=;
 b=Su8H10xkZthWV+czKptCqKnl+76QYT500VBu4CqnTrBJbRwkxWI60tGgolBGAmfImKIWDNv2zLt6jBauDZSN1ufItW4za6Ht6a69aQRMYnnbPG7iNxW5+ep0kuBl54SZ3S43QwiDNzHw2pIUC+oWLhJJV/7Csx2Na5ZilNgiaEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9900.eurprd04.prod.outlook.com (2603:10a6:10:4da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Tue, 4 Apr
 2023 06:02:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 06:02:30 +0000
Message-ID: <6709d93d-492f-6578-0d4d-e244528abf89@oss.nxp.com>
Date:   Tue, 4 Apr 2023 14:02:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <cover.1657187536.git.oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9900:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d1de29-b9bb-45d0-499f-08db34d22c68
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpJXnWmMnU6mIYB7G6t3T1JwIKEaQ8bGPO+Zw8e1GTiTbpryw+5qFBdhdUrGb88R+1upvVBbf+bahhpEbumSg992+vlkSgzKqu3KcBLrf0fgf6d3KpAD9dZplcho1Qblt8mTbg+3XaF3yk+29r6L7TtTxBcHGlxwbeea4OWOUu1NwLc1sBNfHGaWuTUKaLd7qSy5rk0gO1o4IYA8lnm4ZstXGwxQ1rwwdRCykY3HUwDDNVFrWM1gCcsgl+7Pur1OQIDBqLzf10ai75Tj0C3yG+d6uWfrBe3hgzd8JMKOLcKBGa5i0SqH93bfvNl2+L6zdjiW+hEcgf5pKupL7XWKIQsNZtDUFRLnoBkRsnR5YWHZxBA1D/mK0jDmOimM2dBkALWvAQWcbUaNobPIZqAgKfQ+PfphpaD+Y9EZYnLudAH6BP0La94Vnsuk6YZgZN2KLvwUQnEnAIiv0JwY39xswqSpjNYcGXxngM43lTYmkCPfQpSX+i2iZqqgjpwCF8VAelySmMP3rguMk71k5MkX7GRNynrQPi29M1DfbaE4UB6bJE37Ck1JM4JgeeLZL+FMb+i2Qam1dPw5YzpAizGEz/UDtEZVa+pqAav8LTaNYEguG/fCOmw2mUsIGTaWWFBU1wHmv7nny1QeU49HmK9fXvzDZ2BtBnAYNbvmVtjoWBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(38350700002)(38100700002)(6512007)(6506007)(26005)(53546011)(2616005)(966005)(186003)(7416002)(52116002)(44832011)(2906002)(83380400001)(8936002)(8676002)(5660300002)(41300700001)(478600001)(6666004)(66476007)(110136005)(66556008)(54906003)(66946007)(4326008)(31696002)(316002)(86362001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVlzZ0o2ZlVDei9mOUZQeGtqWkc2RmpmNHM2SnMwdjgxZURHZCthRkxyN1J3?=
 =?utf-8?B?bVBMU1lSWWcxR25USGJqT2xoWFlmK1hBMDhTWXdZa0YzdnlvQVdhVUNVTGZ3?=
 =?utf-8?B?bmJtUktoN0JaRmoxRXM5bk9XMmxTeGhJN2F2ZFNKQit1b2Zma1ZJVnlLUjJs?=
 =?utf-8?B?blFLcm9HZlQxdS9aWi9MdnRUSXJOL2VrM0NGS2NFVTJJVFVVWVorOHN3eGdM?=
 =?utf-8?B?TVhhMFh0QWtPSnhJdUZ0Nm1pN0pIZ1JzTWtQZTR3VUFiR21vWlhwVDAxL3or?=
 =?utf-8?B?aUd6N3AyUmlDTDNQMmVjUzJwRmF3Q0ZhNFhJeURMTG1RYlNjUWMxaHd5KzVs?=
 =?utf-8?B?RVZHNEVxUko5T29jWHZ2OWplMjVpWnRXMWh4WitiTXZOZmJYVTRrOVRZdVZ5?=
 =?utf-8?B?SGhCRElpZ3pqRnlQNkN0KzdzZUNFNDZUcUpxRUpKY0tTa0h5T24xVHRnT0Ft?=
 =?utf-8?B?WWhzVFROWjZDbWlOTmV4WWJlR0JTclNISTRUZGljang2RmxLYTRzK2VEaVpk?=
 =?utf-8?B?VmxUUnBFck4xRmw2NmpoRzZ2c0NyMk1oVDlSc29xamQyYU1IaDJXK29OdVdv?=
 =?utf-8?B?Sm9rWlEwWnd5NmtLMlYxNVZnbG1QbnI0VWs3Z3N6VEFEblB0QnhPQ0RZenBL?=
 =?utf-8?B?dGpCcXZCbDljUFloZTQ0RFY1bytTUnRIOU1wVFJqREJEOWFVTDBzUTQ5ajQv?=
 =?utf-8?B?cEpweWEzUzBaVFhyZmF3bzVIanZscTExZmkwNjJ0Z2FxZWU4NFFLY2twWFNt?=
 =?utf-8?B?ejZLRVdBckVUd2lMOVkwYi9SOFhXdFpld2s5NWxwelIzN0ZwaVpFVWlwaTFv?=
 =?utf-8?B?VTNJenNIVzZ3MVNacTkvelZmejU5eFFMUG83c1dZMmtZVlFEK0RUY25veWFK?=
 =?utf-8?B?K1BzS3d1Y09FS2d2aWF2eVNKdW16YkZML2g2UmY5KzlIZlA0cm02L3RYYk1P?=
 =?utf-8?B?Q3ZDYU1PSlZydXdZUE9yUGEvWWUwbUJTTGN1Vk1jdHZMVEkrNWJQVlRIRzAy?=
 =?utf-8?B?dTR5U29WQUFpWWhVQXpsVkU5K2hhYWhrVWR2bnQ4MUE1WGZHMkdITjg3VWJC?=
 =?utf-8?B?aFNMZExyb21CdEFnVFgyRWJ4SFpFcWlhWTJDZ1FLTHB0V2kxMGl4dUlLUTdU?=
 =?utf-8?B?akt4OGhyenpMVWQvb3RSQ3RvRnBueGNXZVpBaVNGSU5YZTE1c2lDTlZoa2NN?=
 =?utf-8?B?OGNjN1lIemtFeE5heDBFa01XRVdLREw3SzFIYW1FNnNSU3JXSUhpM1BtZXJm?=
 =?utf-8?B?ZjByU1ZsZ0lLVVA1YnBDTi9LSHdQdUhUWGFmNGlyeGNmaXEwUjVyM2p1MC9i?=
 =?utf-8?B?MmtaVGJ5VDlyMnlEallzeS9BekRLdm5nZmRrVGE4SXFQR0Rpc0JLaXJkdzhE?=
 =?utf-8?B?UGVaZlpGUFY0TXNzckJ6NnhyNlhlZTI4TDE3UHA5TmNPR0VtR0pjRk05dlMy?=
 =?utf-8?B?MWtENkNCWkE4WkhzMElzM09STmMzaDR5eVBzRGJTOFc2a3praGdlQlcxaVBn?=
 =?utf-8?B?UFpFeEZlc0R2TVBPTE5IRWhZU2d4VTdOSzdHZWo2aWN3WW9ESDgrcmY5eHJ2?=
 =?utf-8?B?bHVERjZFdUJ5MkdRNnczSVEyT3BSajdlTmszZk5mYzQ2VjE0ZmxzM0hYTFk0?=
 =?utf-8?B?YmZnbFJ3dTZIaDZ4L0R0SVE0US9oa2dWVjlRL3B1YWJUUEtYcXg1L0JqOVRo?=
 =?utf-8?B?anVGNkxpWUxxZUxLVUdReGNTVXVSNDhpa1Y5b3ZYN0pxRTUvNXowRVhrc3V2?=
 =?utf-8?B?TWhnOHQ0enVaTE5mbGtzWUJ6VloyYTdHZnJnVWh3eSthRTlUN0crRUZHcURV?=
 =?utf-8?B?d0E4cmpBNGVQL1RWTytsT0ZqdHlrSFplbEpJcFRwYW5GUEgxRFZlRE1RRi9v?=
 =?utf-8?B?eXhES2g2QndtSXRSSUdnZzRaR3ZvVjMzaXBCZDNGZlpFb1NnSi9PVHFJUGZj?=
 =?utf-8?B?Tjd4WGYzcy9PMURGVm9aelZ5NGRlOFlXYURwbHQ0RklITDIyNkRBVVhOSDN1?=
 =?utf-8?B?K2kxRnRTdUt5TnNxWmdDOHlZVGFPcERxTzRRTGVPc3ZTTlRpS1ZXSnViSFQ0?=
 =?utf-8?B?LzU2UnNvVHRBb20ydWNvU1lnRFNTYkNta3VUcnhLemgvdVd3SHdhUjFOdi9X?=
 =?utf-8?Q?R21RBfM8yjj7NlZQZFMgEiRSH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d1de29-b9bb-45d0-499f-08db34d22c68
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 06:02:30.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cn7AGxTVXdziYcNdzBWiYYNFJERf0Rz7qigVRqbktfiebX1psGyYVuMm5VshW9EQ0HoDZHfnzK51yrmdn4u4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9900
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for reply on V4, I not found V6 in my inbox.

Just wonder what is the status of V6
https://lore.kernel.org/lkml/0c0a82bb-18ae-d057-562b-21201bfe4fca@epam.com/

Thanks,
Peng

On 7/7/2022 6:25 PM, Oleksii Moisieiev wrote:
> Introducing the domain controller provider/consumenr bindngs which allow to
> divided system on chip into multiple domains that can be used to select
> by who hardware blocks could be accessed.
> A domain could be a cluster of CPUs, a group of hardware blocks or the
> set of devices, passed-through to the Guest in the virtualized systems.
> 
> Device controllers are typically used to set the permissions of the hardware
> block. The contents of the domain configuration properties are defined by the
> binding for the individual domain controller device.
> 
> The device controller conception in the virtualized systems is to set
> the device configuration for SCMI (System Control and Management
> Interface) which controls clocks/power-domains/resets etc from the
> Firmware. This configuratio sets the device_id to set the device permissions
> for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
> There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
> determine device_id is not covered by the specification.
> Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
> Given parameter should set the device_id, needed to set device
> permissions in the Firmware.
> This property is used by trusted Agent (which is hypervisor in our case)
> to set permissions for the devices, passed-through to the non-trusted
> Agents. Trusted Agent will use device-perms to set the Device
> permissions for the Firmware (See Section 4.2.2.10 [0] for details).
> Agents concept is described in Section 4.2.1 [0].
> 
> Domains in Device-tree node example:
> usb@e6590000
> {
>      domain-0 = <&scmi 19>; //Set domain id 19 to usb node
>      clocks = <&scmi_clock 3>, <&scmi_clock 2>;
>      resets = <&scmi_reset 10>, <&scmi_reset 9>;
>      power-domains = <&scmi_power 0>;
> };
> 
> &scmi {
>      #domain-cells = <1>;
> }
> 
> All mentioned bindings are going to be processed by XEN SCMI mediator
> feature, which is responsible to redirect SCMI calls from guests to the
> firmware, and not going be passed to the guests.
> 
> Domain-controller provider/consumenr concept was taken from the bus
> controller framework patch series, provided in the following thread:
> [1].
> 
> I think we can cooperate with the bus controller framework developers
> and produce the common binding, which will fit the requirements of both
> features
> 
> Also, I think that binding can also be used for STM32 ETZPC bus
> controller feature, proposed in the following thread: [2].
> 
> Looking forward for your thoughts and ideas.
> 
> [0] https://developer.arm.com/documentation/den0056/latest
> [1] https://lore.kernel.org/all/20190318100605.29120-1-benjamin.gaignard@st.com/
> [2] https://lore.kernel.org/all/20200701132523.32533-1-benjamin.gaignard@st.com/
> 
> ---
> Changes v1 -> V2:
>     - update parameter name, made it xen-specific
>     - add xen vendor bindings
> 
> Changes V2 -> V3:
>     - update parameter name, make it generic
>     - update parameter format, add link to controller
>     - do not include xen vendor bindings as already upstreamed
> 
> Changes V3 -> V4:
>     - introduce domain controller provider/consumer device tree bindings
>     - making scmi node to act as domain controller provider when the
>       device permissions should be configured
> ---
> 
> Oleksii Moisieiev (2):
>    dt-bindings: Document common device controller bindings
>    dt-bindings: Update scmi node description
> 
>   .../bindings/domains/domain-controller.yaml   | 80 +++++++++++++++++++
>   .../bindings/firmware/arm,scmi.yaml           | 25 ++++++
>   2 files changed, 105 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/domains/domain-controller.yaml
> 
