Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0327233CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFEXwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFEXwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:52:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05929EC;
        Mon,  5 Jun 2023 16:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB7OSh9a92KGk8IrNVaYSq4Kow+DB4sM3E8q64aUpCM6DPVFtWBHLgR+Fqdqi9zM++R+rIrlrvART6bhzw3Ein193Ewa/J+Ug9+zCVejrfqtY5r3qHzAlcpv1Hqp9mtkGpvBivhDQcpUZ2qSPoK2nIYZ8g0HHH0t/Fg1+Gj7VSviXYi+6nHnse9ygbwgOj3Nbata+4eN9El7xge8Sjq4XRSc3vFGucPxAbvjHHkl/JiwqtRf4OzpDNZMA6BzCI0y4fWxkcgDGbD4E66+FFsSIdh9iSu/hWoau+WgCGc3UBA1/jxSjOjcfbqG0GZvGD63qy2ZtOcmXbKm23y+Ya0RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmRXQKoS1DobXu9N0G82hgBuSnWgeQD53idvpe52tsM=;
 b=kSYdc/NvVol8sfm3vFeENhhNyon2BnOT3CY+1MyNy714NQAArEz4kSeGRIWMsY14CVrMeu5WQWs/Gc/M6ackKO7SGl4fCnkgx50Ift51lRzrfFebR9aHLsgfCy/DdWW3uDEv59HUYIM8qTIB8zCoofeW2yDmzEsey53qABhg2Q3WCPK7pL3iKArqkZ9jyFbV+4fJkSAxRtYbzsz1wlBvHFGXyyyOspkotbn6jyqEI2++dXyq/sUwd7sLjXZ/Y8tSJtRKZpUYWIP0GexZbbMTzRqKG1svUvG/Ci42EbhmmB2RL2nrYWYeb10W+LVJ0msaSk9ATab07dhIHUiQU7E/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmRXQKoS1DobXu9N0G82hgBuSnWgeQD53idvpe52tsM=;
 b=PcFDJjuY75d0S1aUazUS9vOubYVedVMkVQcB0hGZm+SN5jXDUbDgz5WvXRIEN+SxerWeZ2by8S7l1kILyc/9aTfqtwZxM5wnbT5IKeTQovWOOslDzFQ1vlXpf/TN6Zq2ZA3W/kUtU021fbtVcBj5NWxvl87DgPgCuybWwekZ/xA=
Received: from DM6PR06CA0089.namprd06.prod.outlook.com (2603:10b6:5:336::22)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 23:52:13 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::14) by DM6PR06CA0089.outlook.office365.com
 (2603:10b6:5:336::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 23:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 23:52:12 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 5 Jun 2023 18:52:08 -0500
From:   Brad Larson <blarson@amd.com>
To:     <geert@linux-m68k.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>,
        <hal.feng@starfivetech.com>, <hasegawa-hitomi@fujitsu.com>,
        <j.neuschaefer@gmx.net>, <joel@jms.id.au>, <kernel@esmil.dk>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee.jones@linaro.org>, <lee@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <michal.simek@amd.com>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <skhan@linuxfoundation.org>, <suravee.suthikulpanit@amd.com>,
        <thomas.lendacky@amd.com>, <tonyhuang.sunplus@gmail.com>,
        <ulf.hansson@linaro.org>, <vaishnav.a@ti.com>,
        <walker.chen@starfivetech.com>, <will@kernel.org>,
        <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v14 6/8] arm64: dts: Add AMD Pensando Elba SoC support
Date:   Mon, 5 Jun 2023 16:52:02 -0700
Message-ID: <20230605235202.15670-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMuHMdWQGEoB_LLsfLurOV8fT0BO-RYGcsS_Gra49CPiGH9J=g@mail.gmail.com>
References: <CAMuHMdWQGEoB_LLsfLurOV8fT0BO-RYGcsS_Gra49CPiGH9J=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e16ff86-1265-4a58-82d0-08db661fe216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6VGflHSajwVzi8as5yZ3HIf/7H1LrNTWH8zWs3XUvdfPeu/1P85+JZX+RaS0HFvpTaQMFDro/AenD9Z82ZqnDTofqIaLA6cTw6AP18dUYaRV3k5lF7o/Tig9P1ojkfK6PrJCSgbe/kJmG+kOfj/1M+8wuOi3TKeLXdbDCXERVzuUgi2SYYjUcMjM26KripskFY5cfHBzvJ5WA8AoYRvN4cwWhp4GdeB9qCj4ab7yceDymnW8tRFiHDLzNk2+9Wbzm1t9esr2K74xOtcE/3xV1ACZWqslObOShjcn1rcOrxrtrhXT3h309kCpR2X91mGdZb+rHko/JZ3O8uis0rlAzs9DyRXVtVB4KpM6F2FUL0UeNUaIWT2qBOIR7bNyMwtYAAp53mY0ctUBo4Ff28vQTH6jIVVj5WjnYeVWq2WUUcQJjvmGeLbeFRWIsjLAugdI6SHZ0hc6qfqGKoLxZ3ZgfC3GQNxMRUZNDv3E/oEfDUruySh8+ka6FP/WDTVhiIo0nG1lpJ6of5yVg74UW36SJN+rbcv6EsYvdjvqBAwnOm3PIi6jgRQljRVAbkF2RdtqqoeqCOhBKLVMFnjrjYaxoeuxTRqC5jvHN+utAUYeRSMpXfhZfT9rxgOlO6S0jq7RMYwoBAQvWxYWJIAczzO9XHtS6ajmSZ/rwe3uXqhy8TZRPfDEwDrO7sr0IYPxvUi55dOlq0Uj+ouniMnRRJ+2TbBkhIZptV9Nn7xyQ8ZjdufmdUsOJ9ZWhFmiqquOHrTfzQDNDC2Ac71LiHb9Q9rzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(70586007)(54906003)(356005)(81166007)(478600001)(82740400003)(8676002)(8936002)(41300700001)(4326008)(6916009)(316002)(70206006)(2616005)(186003)(426003)(336012)(16526019)(36860700001)(47076005)(40460700003)(6666004)(1076003)(26005)(53546011)(82310400005)(5660300002)(7416002)(7406005)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 23:52:12.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e16ff86-1265-4a58-82d0-08db661fe216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, May 31, 2023 at 15:09 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, May 31, 2023 at 12:04 AM Brad Larson <blarson@amd.com> wrote:
>> On Wed, May 24, 2023 at 13:52 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > On Tue, May 23, 2023 at 9:30â€¯PM Brad Larson <blarson@amd.com> wrote:
>> >> On 5/16/23 09:54, Michal Simek wrote:
>> >> > On 5/15/23 20:16, Brad Larson wrote:
...
>> >> >> +            /* CLUSTER 0 */
>> >> >> +            cpu0: cpu@0 {
>> >> >> +                    device_type = "cpu";
>> >> >> +                    compatible = "arm,cortex-a72";
>> >> >> +                    reg = <0 0x0>;
>> >> >
>> >> > Do you really need 2/0 split here. The first cell is 0 anyway.
>> >>
>> >> Yes following 64-bit system definition
>> >
>> > You mean for the 64-bit main address space?
>> > The CPU address space under /cpus is unrelated.
>>
>> Yes, the reg prop for this node is CPU/threads per dt spec.  Checked the history and
>> the Elba dt was derived from socionext for these nodes and this is how those device
>> trees are configured along with over a dozen other devices.  I changed to
>> address-cells = <1> and dropped the leading zero from all cpu* reg<> and booting
>> the system I'm observing no change.  Looking in drivers/of I'm not seeing where
>> cpu*/reg is read and used, any recommendation?
>
> drivers/of/cpu.c
>
> Looks like there are lots of DTS files that use #address-cells = <2> for
> CPU nodes :-(
>
>     git grep -w -A1 cpus -- "*dts*" | grep address-cells | grep "<2>"
>
> I would use <1> is the first cell is always zero...

I'll do that.  Tha variation across DTS is likely coming from ~5.10 devicetree/bindings/arm/cpus.txt

        - #address-cells
...
                        # On ARM v8 64-bit systems value should be set to 2,
                          that corresponds to the MPIDR_EL1 register size.
                          If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
                          in the system, #address-cells can be set to 1, since
                          MPIDR_EL1[63:32] bits are not used for CPUs
                          identification.

where the size of MPIDR_EL1 register is 2 for Elba cores.  However the shorthand is
allowed if MPIDR_EL1[63:32] bita are not used.

Latest version:

      On ARM v8 64-bit systems this property is required
        and matches the MPIDR_EL1 register affinity bits.

        * If cpus node's #address-cells property is set to 2

          The first reg cell bits [7:0] must be set to
          bits [39:32] of MPIDR_EL1.

          The second reg cell bits [23:0] must be set to
          bits [23:0] of MPIDR_EL1.

        * If cpus node's #address-cells property is set to 1

          The reg cell bits [23:0] must be set to bits [23:0]
          of MPIDR_EL1.

      All other bits in the reg cells must be set to 0.

Regards,
Brad
