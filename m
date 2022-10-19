Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD636604735
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiJSNek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJSNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:33:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAF1DF421
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:22:45 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=WHjtW4fmZMKmbIU8trT+g3Y973vg96dfJ46zaSa6J8h4IY/CnMOcrHvmchL44bnQYxOQV0hAHzbvsVoeGertYc3+1CdL4MCeFL9z0r16HU2ugSNCZTfzjTO7Dr3JK1s+wZJbmzp6VwEdDWFIBPKQXAyBapb0l7hA7Z9NcHevF7ool3sQrAbDkD+a04ODi8dOYjtsA1fQHxWkvi5X5jdjGgzQzDSid9T6UJBSMpbkexgsXFj3iyBusYL+jyDfTxN0jDFhCFOIspF956kUTEuZ8JkP+KR93yhwLiCaeIOtsYWCTZ0bTjuFraXiK837cKcE3AlYtN1gybaUo5s1vftyhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP7ecCPQZj6FK2Xg6lgGmwc3sKsF3DI1Eopu8b9QXi4=;
 b=j6ZUYphKA8Hly6/Un674uYmUDzJp678aDidpgYzUg6groXEkFLqyNSZEVRD0iZcqsDcunqPr+LekYQAtEUR3/I+95mBdjU5cfQhXMfQfotUyiF3XrPzjG0RuJ7/5mNfnU2fUpOkeLxmjMl/X8kJV1If651Yo37SPEOZv1bTAV/BasWVrIu3ayIYOSKLXR7kA1Ahqdev0xTBs3i4RitewpAVPckHLoQuzFUb8VMfWOzkO3oN5NxdBrkS0bE+HfyLU2VdzWy+wjYcyyHazGbFcdm7OgQHaHe4QYroP8ezNmiAw+xS17a843sWkN7XRUBbhkRXMjBKA5fNJ4sp+ENrEjQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP7ecCPQZj6FK2Xg6lgGmwc3sKsF3DI1Eopu8b9QXi4=;
 b=BGqbd/KXdyM4sFKuI5BqIbu5q/XxecdmSeDvQR8shuX+r8zjrAYw39BCtQUh1guJUvhvfmwFdbx0dZ2bE8lbNBMbv5xnr3CUvPsV8HVZMvtjYfRHrKo+VWT+QD1oL2TALWrALnnQ+GrQM512ArF7O98ElEz835nLhlPP7e6B1lU=
Received: from FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::14)
 by AS2PR08MB8696.eurprd08.prod.outlook.com (2603:10a6:20b:55f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:20:40 +0000
Received: from VI1EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:1d:cafe::e9) by FR3P281CA0008.outlook.office365.com
 (2603:10a6:d10:1d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.17 via Frontend
 Transport; Wed, 19 Oct 2022 13:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT017.mail.protection.outlook.com (100.127.145.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 19 Oct 2022 13:20:40 +0000
Received: ("Tessian outbound 73ab5f36653e:v130"); Wed, 19 Oct 2022 13:20:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: be79b5d74761632b
X-CR-MTA-TID: 64aa7808
Received: from 66413d5b64cb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4B9E8F46-BE3E-4125-B8E4-DF3471BF8144.1;
        Wed, 19 Oct 2022 13:20:32 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 66413d5b64cb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 19 Oct 2022 13:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezr/D3zK2nMUaaulxaDwzO2eeUdwnURWci101s62S1mmqQs0sUooEtd/i3VK82DZIL92Pem8wPpRbaLrzHEzWqrdABSsZw2vYXqt1nLhDDyybeGrScPngwDMMKtAxNQXmRtVph2qTq71RpUUcIE6d0qIr21q9r5OE9mpei4st+wPFeJb9dMmhGDlX8SBqUNX/Ry29HqLtMl+8QDCCUJ1EtMg55KZiobFcHEpi7s5hOY2OVDC1GXbYGmYAvNi+KM20g6TFkpr3TSw0X1YHngYpH8S9jkDq4wfmHz3iFmdESR81pbXLFnJIYXUB83NMT8262GFd2rmPqHXtybgzOD8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP7ecCPQZj6FK2Xg6lgGmwc3sKsF3DI1Eopu8b9QXi4=;
 b=KzqcEsikJyKnAxVamihQ/OgwjowPSY7O2H0ZwkIuWzvJAjyehMC06zkmVGAtFR9B3I+w3HxL2j9BwdS6AlogNicARznj6vtAkTrIhoMNGIrde9C9xkYLuILtlyfRYNqw1hj6oGwn7db4exp1MWnKaAIz4EllfdV2UD3/nwuliD/kbEsE4R+xwp/+rtzzmwEQcNsZ58z8Wo7PDVpXYnlcNDxnAvvL1fdXBnD66wg9jx7sAyUefcYA+fFZmFucK9pR/98U8uRBVhUz9CqZapTtGeP2MdFxY3PQ872M/IBqX2j0WL1px4U4ecMGqCTnMXIAQzxnPFuHc4pLxHqtZSvx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP7ecCPQZj6FK2Xg6lgGmwc3sKsF3DI1Eopu8b9QXi4=;
 b=BGqbd/KXdyM4sFKuI5BqIbu5q/XxecdmSeDvQR8shuX+r8zjrAYw39BCtQUh1guJUvhvfmwFdbx0dZ2bE8lbNBMbv5xnr3CUvPsV8HVZMvtjYfRHrKo+VWT+QD1oL2TALWrALnnQ+GrQM512ArF7O98ElEz835nLhlPP7e6B1lU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB7462.eurprd08.prod.outlook.com (2603:10a6:10:355::15)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 13:20:30 +0000
Received: from DU0PR08MB7462.eurprd08.prod.outlook.com
 ([fe80::bcd5:e301:a28:bbb2]) by DU0PR08MB7462.eurprd08.prod.outlook.com
 ([fe80::bcd5:e301:a28:bbb2%3]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:20:29 +0000
Message-ID: <cbe665c2-fe83-e446-1696-7115c0f9fd76@arm.com>
Date:   Wed, 19 Oct 2022 14:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
 <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0662.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::18) To DU0PR08MB7462.eurprd08.prod.outlook.com
 (2603:10a6:10:355::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU0PR08MB7462:EE_|PA4PR08MB6032:EE_|VI1EUR03FT017:EE_|AS2PR08MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aada64c-4a4e-46c3-c800-08dab1d4b814
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LLdhNoyD6sRKzoVpZmvoriDpH9gLBxys+9S6AwEYL1hjHaUvvXI2LTmbseSXe8N9EXDGmhMODqaLET5uWrGzWkqGYs+lcRTi1fD7JYMnuuPd+wR1N1ZZrep5BCtiV9J25+j25BW85doPNOXOec5sh6s7IfN6i41tQz7EXt23atc7oOAl4BE+bxm2bNzzp4MLy61i0oZfFQALXN1HHPnoI/fpuV+E5/DYd0TKfQKo4PpqRpmOOYW1Ltyyh18Ht+6pOJwQkFD5+SyemDqBqWJqXiSaO/3JtJUUiRfbw0nP1PlnHJ8KuO4A9pAjexI/myo4jVuiVCKExZ616t63F3VXGzQjZOKUrQ28lZL1vrrdBaLL8Q8ZF4D/hZnpJvmZow1zwwkctXLI5DnJzOdCViFHItkomE41o2eBzH/wsU4GvC0YO2aJgdgDo5Ua4sqbDoYETdQyplb2p/zyeuPoTkoNCNeh/9XELt+fHofLWN9ZFtCk8NA+8obSIDJc6KpT+BS2JVPgSzYwJkd26flDf3+FZulve/qBDFJVG6vg+sM0qtyYZ3D7LcOlYyohg2c4awonq1Dt50m9peO8S03UiGA03sWYKWM3iroZ8RdpO8ao4nbY9KJT6hXdNnxDVX5wcDal0L9kpVtaVwtImtWBThIopq8aqb1n+syNsZO7qNSEDuUDsfVNBuTl3g/qmpeU+GOp6ltLSc1ESnE4xRFtTT2T76uTfpjnbTuXa9cs93hMd/sJx+99uwl6UoF7yqWzVg7xYISNTQYd3nSt3vzDYnjjyWaEixDGvKTgQ4k29vvMXaA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB7462.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(6512007)(6666004)(6506007)(2616005)(53546011)(478600001)(26005)(83380400001)(186003)(5660300002)(44832011)(54906003)(110136005)(6486002)(316002)(4326008)(41300700001)(8936002)(66946007)(66556008)(66476007)(8676002)(31696002)(86362001)(36756003)(38100700002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7a78b8b6-e72b-4526-5464-08dab1d4b13d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wB6AsPdoxuBGNb2+omo4VF1aGHWxPysqCDp1Q7JM+wvnAdpVAVPqlKQIcW52u1b+mHInW5bcr2keKvKA7uMTVPZ0bas7/ZoG7r4YsZB8u/rLb/njlhNrAaJLxb9mOvRNW7KG3RBNGiRwikdHO65Y+UnoM5uUMGy7UOdTVgrGzkgd0Prjo/e3t/WzNNAOuCS3Ar6pIeKwTBJ04/I1IsHwprX5wHjpSHxHt1u9QPMZFwFRxFAsqmUzYn6SUwTxjbdLW0Ooq1i+K2Gu8Dg7rgcXlS/R1FglUEX3a3+UxH1lvcfiNAfyxNp5dqiuTigRlMqIRNzFq00r2kM1VQlETgoXMF5/nnDyVr12413IGvvDeENWqRtm/Y+RdyVCDh2d7t0p7Zq4AT4HY5o8sfj06ZgZYBwSs0ATWLqDlmse+/REUE5ltwOVRpj7ccUCiXcNiWBwBVQOCmNA/tvloVHMYGBJkkxc67uonBWE8DzzMel5LFquMbe5jz/WF6bBPeZD0/97AmT734opWPxZBpIWeZHUIHrUX4wfOjm6RTapjynVWblOVZoAq5NSCJ7lvDIRErcusbxQXGWulP1AYmoUCLNVjryyfmxasnSXL+7bc2WvMc5td3xIW533m7Jj7YHiji27Y+MPUBFVpNiGQHTURqefslcuqgU2VQmj9Ep2VciysD8EI1S7izJU1UoE3r9ELu4whXXhCiWMt1W9WsuyxvuCWXEfaIV2mYuxV01uU1La/cVfkUko3M3y8iwwejDkhvV5tIVkW4mVvqv8nk4dvrUfFqsLoz3UYpuxZ73gu/fVxVl3zCqUrxKlXf6HPaZ8Ijmj
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(6512007)(2616005)(53546011)(6506007)(83380400001)(336012)(478600001)(186003)(40480700001)(36860700001)(47076005)(107886003)(40460700003)(44832011)(6666004)(5660300002)(2906002)(110136005)(6486002)(82310400005)(54906003)(316002)(4326008)(41300700001)(8936002)(70586007)(70206006)(8676002)(86362001)(31696002)(36756003)(356005)(81166007)(26005)(82740400003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:20:40.4805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aada64c-4a4e-46c3-c800-08dab1d4b814
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8696
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 19/10/2022 10:08, Peter Newman wrote:
> On Wed, Oct 12, 2022 at 7:23 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> What if resctrl adds support to rdtgroup_kf_syscall_ops for
>> the .rename callback?
>>
>> It seems like doing so could enable users to do something like:
>> mv /sys/fs/resctrl/groupA/mon_groups/containerA /sys/fs/resctrl/groupB/m=
on_groups/
>>
>> Such a user request would trigger the "containerA" monitor group
>> to be moved to another control group. All tasks within it could be moved=
 to
>> the new control group (their CLOSIDs are changed) while their RMIDs
>> remain intact.
>
> I think this will be the best approach for us, since we need separate
> counters for every job. Unless you were planning to implement this very
> soon, I will prototype it for the container manager team to try out and
> submit patches for review if it works for them.
>
>> I just read James's response and I do not know how this could be made to
>> work with the Arm monitoring when it arrives. Potentially there
>> could be an architecture specific "move monitor group" call.

> AFAICT all we could do in that situation is hope there are plenty of
> CLOSIDs, since we wouldn't be able to create any additional monitoring
> groups.
>
> What's still unclear to me is exactly how an application would interpret
> the reported CLOSID and RMID counts to decide whether it should create
> lots of MON groups vs CTRL_MON groups, given that the RMID count would
> mean something semantically different on MPAM.

Yeah - its top of the list in the 'ABI problems' section of the KNOWN_ISSUE=
S file.


> I would not want to see
> the container manager asking itself "am I on an ARM system?" when
> calculating how many containers' bandwidth usage it can count.

This would be a terrible!


> (Maybe James has an answer to this question.)

I don't. Its an unfortunate difference that is visible to user-space.

Currently the MPAM tree proposes to expose '1' as num_rmid on arm64, becaus=
e the right
answer depends on whether you intend to create monitoring groups or control=
 groups.

My best bet is to expose some new properties, 'num_groups' at the root leve=
l (which would
have the same value as num_closid), and inside each control group's 'mon_gr=
oups'. For x86
the later would be the same as num_rmid, but on arm64 it would be the maxim=
um PMG bits.


Thanks,

James
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
