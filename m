Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B546732FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbjFPLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFPLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:38:17 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01hn20319.outbound.protection.outlook.com [IPv6:2a01:111:f403:4012::319])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6030C1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6ndovz2ZsPi6xWN1IQZG+0viS09CSYUhuJPUEpt0oI=;
 b=LpgWNYRK8n7JdrNx81zuX2JJ3cWHv4Ec5NZF0WdEO/BDblkASx33fgsjL/4eiz1YZqYoHOCLC5XNDNiG6b4v+y0CUjD6LXMoWWZ0bb/WLjNiUIIYFdSMy35/16pHiB3cp8I0mhrVg+GBvo4VdGOjBaLBsrkRlyCLQ/wwpc0LLZs=
Received: from GV3PEPF000000DF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:11) by ZRAP278MB0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:11::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:38:08 +0000
Received: from HE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::208) by GV3PEPF000000DF.outlook.office365.com
 (2603:1026:900:3::f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Fri, 16 Jun 2023 11:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 HE1EUR01FT097.mail.protection.outlook.com (10.152.1.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.13 via Frontend Transport; Fri, 16 Jun 2023 11:38:07 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4QjHGR0DYzzxpC;
        Fri, 16 Jun 2023 13:38:07 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri, 16 Jun 2023 13:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6ndovz2ZsPi6xWN1IQZG+0viS09CSYUhuJPUEpt0oI=;
 b=LpgWNYRK8n7JdrNx81zuX2JJ3cWHv4Ec5NZF0WdEO/BDblkASx33fgsjL/4eiz1YZqYoHOCLC5XNDNiG6b4v+y0CUjD6LXMoWWZ0bb/WLjNiUIIYFdSMy35/16pHiB3cp8I0mhrVg+GBvo4VdGOjBaLBsrkRlyCLQ/wwpc0LLZs=
Received: from DB6P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::13) by
 ZR0P278MB0797.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:42::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.29; Fri, 16 Jun 2023 11:38:03 +0000
Received: from DB5EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::18) by DB6P192CA0003.outlook.office365.com
 (2603:10a6:4:b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Fri, 16 Jun 2023 11:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DB5EUR01FT021.mail.protection.outlook.com (10.152.4.245) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.25 via Frontend Transport; Fri, 16 Jun 2023 11:38:03 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.45) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 16 Jun 2023 11:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeGkCUK6gq5FxfgaUVqzyL8sepxUjGtEucrjKdYwJJ446hHmT30TWR/fGL3Rh7e19/uDqIrpguwSW7vVF7VbEW0MzVtmHBvhZYB8kFyp8MEzpQT+v51bSeLRYOWvEmp78OEdb0tdeVwzjQ1T+36IFG8okcz24ISHHGZbxYo78J6GXhb+RWw2A5NlhxAOYfDHY5C1VjmgZTRvgYgVv4nJhXr6EC06FX3dQFOwCF51GAOIZ3pc964zUjZ01dyUmxiduTW99c1YRPKht+mX6YnBQG6StI84PxVQ3rblbzi0LiBZKEkQQ79P9zEfmwzdR7u+bm5nKtyeS1fGraAV/AakLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6ndovz2ZsPi6xWN1IQZG+0viS09CSYUhuJPUEpt0oI=;
 b=LhDn4wcJj1kE33Cp1AAjDxzaE6s0aHz2zTi4OsOY5+VlSDGoJbIz5omt7P26zTnm0FJ5sXLAXQtWoEz0NXh/6WImh4okpODZBwr0hZO4JY5iuJjHiHW8IUbpr1Oen/+xA1YvLBYkRrvPuu0WXjFdVW3TtFMjaGhJzMGB7JdGYkWJDoahosDPfdKSHZPNUwaaqulbqPWM42ZOaTOP0dx0y6LanHmePXlSMqZJM4w2ieptHZcGjxASvNNF6KdFMjwpXHTrZywLblEgoQsMYuEjVZECCQMEOznLhZN1FrGp3X51K0oYND3dEnNM49Us+8vjlVeVZ/KD9zknLHPQJJ+j3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6ndovz2ZsPi6xWN1IQZG+0viS09CSYUhuJPUEpt0oI=;
 b=LpgWNYRK8n7JdrNx81zuX2JJ3cWHv4Ec5NZF0WdEO/BDblkASx33fgsjL/4eiz1YZqYoHOCLC5XNDNiG6b4v+y0CUjD6LXMoWWZ0bb/WLjNiUIIYFdSMy35/16pHiB3cp8I0mhrVg+GBvo4VdGOjBaLBsrkRlyCLQ/wwpc0LLZs=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0800.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:38:00 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6afa:fd18:1d96:496f]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6afa:fd18:1d96:496f%4]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 11:38:00 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH 1/1] mcb: Do not add the mcb_bus_type to the mcb_bus itself
Thread-Topic: [PATCH 1/1] mcb: Do not add the mcb_bus_type to the mcb_bus
 itself
Thread-Index: AQHZoEcAY2/zqKRWEUeuOIgtKevufw==
Date:   Fri, 16 Jun 2023 11:38:00 +0000
Message-ID: <20230616113732.83210-2-josejavier.rodriguez@duagon.com>
References: <20230616113732.83210-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230616113732.83210-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0800:EE_|DB5EUR01FT021:EE_|ZR0P278MB0797:EE_|HE1EUR01FT097:EE_|ZRAP278MB0047:EE_
X-MS-Office365-Filtering-Correlation-Id: 71400087-e1f6-48cf-9bf7-08db6e5e27ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: olfu4tA/kdxYQi4H7fhEe6SxjuOvmhdVWrPrlaNO2WvQ6W5VzxTxVDhBPByb379Zyao0BAue6p9J+HnQfLqt7u9zG6vStNtgwwHD3XTPf47J47qXY/pVBxdriyVVF4W6Jj4LxMd23lQtOl+T591d4CG3UFQrfmMOKRJcWRxefxrV8NRA84zpVxBxF/8rh5Z2NljnBQRELyXTa7pWDt7dWqZyAah9se9VK2al6E5c0uxSjG1mec7YvNqKrqGqOJex64oCOiI+PJiMMR5nM+03727/JgVzTjsEw9tw3jZLJfnFt/LFvQKrN2rNNk7xcCIeA2I1nK465or6w5+dcp9B1obvkmbCPaCR2xGqAdUpOMvblMiocTI79X8zRLEYl6UvXy7jBtp2swR/z/3dxkmK5g7wt2osKDYuAUkMP3j9/ZC2JbMiWIGB3UHxz5mgnGEKaTGNruaYXr0a4F0DbH2ThrUVvbihMFXpmS6Ny+TIhvGWZZw0EUqK4cY5T6PGd7wk//Y3YsWta20nZ+vLDRVYn5tB9/vx63OHLBvGogwRJldyGACCHsz8JY8w/RSJPAqvvHHymgw1p/62U5IwM3KeUtZDqJWcVRCOXrXKsWlew8ILqZgXLoJY+aQ0hsPuhTLp
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39850400004)(376002)(366004)(346002)(451199021)(36756003)(86362001)(38070700005)(54906003)(66556008)(64756008)(66446008)(66476007)(316002)(6916009)(4326008)(91956017)(76116006)(66946007)(107886003)(71200400001)(478600001)(6486002)(41300700001)(8676002)(2906002)(8936002)(5660300002)(122000001)(38100700002)(2616005)(83380400001)(1076003)(26005)(6512007)(6506007)(186003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0800
X-CodeTwo-MessageID: 3d0a9ea5-73db-42e3-ab93-7d1c1d2ba8f6.20230616113801@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT021.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 17b266fa-cdf6-4022-bb08-08db6e5e236e
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: A7RewzoRB7YEY0fZf94Vnt9/NtH2u9DWd70WxP5ucu5r9ntMOhfjAmJEZwq+TY/EGyU1Uzp3PhV0tZRWUx5p/c8R2Eu2GRZsaT19YP+tgg5ZEDxIxCR0jjp2fLGDw9MdAkfGSnhBxf1cxGdkUUqIFCyAJsSqeMiD01Y1sUBfW/sHweopUGuxlBCFGPcywgvQzAnnvf1qBctmppS+DpwA/gRXyaS9Oty0sPUUebhLC1TCsOUWZx37kTdoHo0vMGoyBZndC+aRhzzbSvbykBxAk0eBeBjeq5vHyHs7Qb6ZcITcVr+SfjgLVARwWvWC1srhoXB2BFjTp/7urOOMk8KXbdRL/SPGWvQjNp9mOaABzNl9UmOUolDbojgDq7VHiNThH1kkhwgTrjWxpSAmPa1ZcCa+eMXES0VMvGJ/VXn5Qig9cyKoSTC08NzwIhVZ4RnOUa4jNb9l2kdX7r/d6sKGxEbT+sPugn4pjrPahm085SWVr8zt25NFrPwIonmWiPNfVMER42xwNPUfOak6YZzMjYmfTrgMK2CCfWdnEBUQSSD9gftkhNnfTu6MiZ+v9W6g76VGLqCCRmGWmS7o3rDG8HPDRqaKFhNdxBfpuHIOXFWH/4g0vobTCDKPLrI9Uj2V0c5YliYwP0PFf3qI5x3WNiQsQY19PLsv7HzSVvVNerqUw6/a5YnQOjkZZB/mWWg/gwVk+4j+iR7YQpXBbMLzXw==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(136003)(396003)(39850400004)(376002)(346002)(451199021)(46966006)(36840700001)(36756003)(86362001)(70206006)(70586007)(54906003)(316002)(6916009)(4326008)(107886003)(478600001)(6486002)(40480700001)(82310400005)(41300700001)(8676002)(2906002)(8936002)(5660300002)(82740400003)(7636003)(7596003)(2616005)(83380400001)(336012)(1076003)(26005)(6512007)(6506007)(186003)(36860700001)(47076005)(356005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0797
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3efde6fe-d3cb-4310-679f-08db6e5e2569
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTWIIMFN5jgp3KIIwjfb3FzAsh+VGdD2WGgDTTpQbYjccRW0XZpJQPXMkYKIZ2tN3HUvCCHX85zmRww+mVAJ0WqhEk7xe8qK4IVEnF9a4aeApO460aISzPQFFXsRysm3ScUEoOEZq2CLbjVvieYz4s0UkQO74Min81S5Gx0cJ2+V1MRDw4RIBG9YcdS3zJUtPVH660D2JryccmBLUwmvhKUyHYOTRKsqVF5FxBnXvKAlmDLR1ue9wO/EUcrNZPM5CDZlTtc9B0XDU8DgL8JJ6UMJp8iuuFRxKAcykhdiWqfuHqL7aOuAekro4aaHYht4LoXc5woJHPAjHP0arc+4dZO8W4zmncfZcaqHfotBhqHzr/NmXiADLlz2P1JPG4AqpapSXgR+Z4yKmK9VjmRNYlF9qREY4DQHnCxK9Ah/tkKkOw9U//xqHFHdi5EV8GFsaS1BNVokW7EdHH/fjiD3GGE4o8BcQzr73orFf6tECdDxbpJ4I2g84KqNBY1zWf2EupnkyezgW0krCdz56SSfct8Q1L2s5lJ/kkOzGaWmHlUOSncBr3TWbqsO2ZLHvmgmmdjmtbweWor8ugWh4ne4MznBKIogGd7F7s08DToJH6leMzrdRuOlKAmmFWLcs7BkqJ1aRHiqevpokiJDiW+4TtIeB1Weg2dP7Ay2MpnirofohOXAgqV3n8QPHYHD40ZO4b1HiQqTdIRz4sTre5digb6UfWGjRw8DmQQVKENAFyUcyscdGauOXZuMuUFRjTbjKFAc3PTTt/3hY6MvAlyh6Laz6J9XFKJ6bEgJJGdp6vjKmU846PcMn4/Y66vrVKPw
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230028)(39850400004)(136003)(396003)(376002)(346002)(451199021)(5400799015)(36840700001)(40470700004)(46966006)(107886003)(26005)(6512007)(6506007)(1076003)(36756003)(40460700003)(478600001)(186003)(40480700001)(6486002)(2906002)(316002)(41300700001)(34070700002)(86362001)(81166007)(5660300002)(8676002)(82740400003)(8936002)(82310400005)(83380400001)(54906003)(336012)(47076005)(2616005)(70586007)(6916009)(70206006)(4326008)(36860700001)(12100799033);DIR:OUT;SFP:1501;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 11:38:07.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71400087-e1f6-48cf-9bf7-08db6e5e27ea
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating a new mcb_bus the bus_type is added to the mcb_bus
itself, causing an issue when calling mcb_bus_add_devices().
This function is not only called for each mcb_device under the
mcb_bus but for the bus itself.

This causes a crash when freeing the ida resources as the bus numbering
gets corrupted due to a wrong cast of structs mcb_bus and mcb_device.

Make the release of the mcb devices and their mcb bus explicit.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/mcb/mcb-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 978fdfc19a06..d4535b8aea1d 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -251,6 +251,12 @@ int mcb_device_register(struct mcb_bus *bus, struct mc=
b_device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(mcb_device_register, MCB);
=20
+
+static void mcb_bus_unregister(struct mcb_bus *bus)
+{
+	device_unregister(&bus->dev);
+}
+
 static void mcb_free_bus(struct device *dev)
 {
 	struct mcb_bus *bus =3D to_mcb_bus(dev);
@@ -286,7 +292,6 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
=20
 	device_initialize(&bus->dev);
 	bus->dev.parent =3D carrier;
-	bus->dev.bus =3D &mcb_bus_type;
 	bus->dev.type =3D &mcb_carrier_device_type;
 	bus->dev.release =3D &mcb_free_bus;
=20
@@ -322,6 +327,7 @@ static void mcb_devices_unregister(struct mcb_bus *bus)
 void mcb_release_bus(struct mcb_bus *bus)
 {
 	mcb_devices_unregister(bus);
+	mcb_bus_unregister(bus);
 }
 EXPORT_SYMBOL_NS_GPL(mcb_release_bus, MCB);
=20
--=20
2.34.1
