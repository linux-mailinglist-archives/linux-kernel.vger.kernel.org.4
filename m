Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C01633621
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiKVHpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiKVHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:45:23 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B49317D9;
        Mon, 21 Nov 2022 23:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669103122; x=1700639122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qW2nERCqXNZeqT592ciG1J6Nf/Ia19JspGpBSaLIGzk=;
  b=dLFr+SSX/wS1ZxFxphxwYzWGmcVh5Jnn5v25nYOeNzDaR7C3nb4TMChZ
   G+CEI39ybTFr1Nn1QfGhcNd69/tPKhmQAhby966qYWMKxvaWqWL+/pLCX
   p5t3knS9mbcvT4VpaWaV6g1NG+3uchWfLmwIh7RDLk4q3YCQlqLTiPyQB
   hItW9obChlAHTImkBUT8/PRpeiZs4wPUiHrnr16ckr94qPgtpFO/oV6ZZ
   dF6lUHNV4VZwsdPNRo2q2reEprYkWj4UNV7BaZEaOTPuJzQylAn05nnT5
   JNzeGRTq+QiNL1MHnmylrIX1XrF5fsET3ybRfogZlK1f6GLgn0wpu5ZTZ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="222027765"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 15:45:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM2cR6lTao2P4qBSOah31KYXOOWVYmgQBDIZWAGRRb+0zFDHpgjrKvUeuBWAIiIUqm+y3Tzt5hmj/e03zIb+HyagZu/cyCeeIX+Yf8dzPM3i/CQ7tSbWYGweMgPQj/2Cxw89fMz8SM3Uou/x6bGPGzkt6L7w56TmHq1paGjbV5PGs0cjs7m9aGMiOP71s7QedZ6AB9SZOIefLpQ9l4nDSZ+4+LrKz/h9U4i4UvyedOZLOuCDDtUFODnJo3L6ObPSe2Qdv5NQrXVfXxMuXEsWIdTpo2/sL+iYPcrHVvWkmuZt5LDsD/uwXtXyjcEhW4I3A68QMnOlCEKf0EHUjq634Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW2nERCqXNZeqT592ciG1J6Nf/Ia19JspGpBSaLIGzk=;
 b=QNYEFHi71vaAlPfQm9W0s+Vn9Qf/E+pI5hN5U5GR9oAaxwGRbNPDtQzMK1N3/r3qD2VOscztWMBD5UEUbBq/T76oNHSlmajem6EXMod/22aPbAE2BHWqCUj2uWcjY98O7EwekGGBok4lhzQf0bal2ebcv70muGBuZVwdDcjw2JJ3ZwXPuZgb9AmBuflGB/Ruiv2SDLQLAo8j/UEDVtxpo+YwUWB9qELEujfpkUQnbvdDTRnIcwsMde+Oq5AQ/nyzwy3szdhKMIxU0kT71JEI91n9yJOKaiHjcyyL7OWRLUq/+Wit2LuEoTPigztg8InRNgTO/+Ee6awPG2kjw3J9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW2nERCqXNZeqT592ciG1J6Nf/Ia19JspGpBSaLIGzk=;
 b=DTOz0oWGtXkpnjn9i5qCNDTO5eOqs/v7tiehAwhzP4E9OsDQOeBk8kAhYVl1hVIh8z5hWnI0ZnDpSYq7KzmwHXm+EExa9FRnkoh4B9s4A95CCpv0GpHS4DsDDt3WSlFfA7oEAAP1gOzxqMKorXsDngiqFlBpT4tLNnubdxiwDJ4=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by BYAPR04MB3927.namprd04.prod.outlook.com (2603:10b6:a02:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 07:45:18 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::6a9d:858b:63f9:92a0]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::6a9d:858b:63f9:92a0%6]) with mapi id 15.20.5834.009; Tue, 22 Nov 2022
 07:45:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Peng Zhang <zhangpeng362@huawei.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "seanga2@gmail.com" <seanga2@gmail.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] pinctrl: call of_node_put() when breaking out of
 for_each_available_child_of_node()
Thread-Topic: [PATCH] pinctrl: call of_node_put() when breaking out of
 for_each_available_child_of_node()
Thread-Index: AQHY/kTB3BevQNuF0k6Nr3cVROipwa5KkDEA
Date:   Tue, 22 Nov 2022 07:45:18 +0000
Message-ID: <e10a7764-7a81-b3b9-aecd-6b5a947f1e19@wdc.com>
References: <20221122075853.2496680-1-zhangpeng362@huawei.com>
In-Reply-To: <20221122075853.2496680-1-zhangpeng362@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB7081:EE_|BYAPR04MB3927:EE_
x-ms-office365-filtering-correlation-id: d71fba21-7a24-4140-1277-08dacc5d8064
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FA8aPasax0/aYDvsQHyeAOEOIE7Z8eGZzgI6ysW1z/VgRLWrnEMdXHDm3JD2hgK9UBcey9dR3X348Z/Ha+1Ygyf6kACN2Nvx2P/FeVaUXzKclfhI6J3/0NT0qcIKIkQGh6zqoJvZg8VyLWL8j5fVFSI0GagZV6p9SELVWq+re5nasHPGmnhVBAeXSe6G5+khHrwzZVTPiLX8neCw/vMQYMjnMz00bOUYP52WjX/bTnbEHbTCSuQWaJWdP1+hMZlA4s7tkrB/gvWd31JeI/TxK+U7dbtw+94ZiXJCODB64plM4uWQCmVz7dV2RAzU6wRYcT6sRkWb5Asihsn/NhEmuxl25Gted9TwaztY22Zkgw78PfwTmGGNgx4XzfI4kwZrDqNFMvP4R6dvgcdT5cNSwQ7WmVocvrNEBI3vCK+ecuDhoPt7adF76ON/KLcRGlqeMB49VmPTTiXmbeIe8ewcPDBARx6vfjf+5zUvZyWpAE//3geOgQ0SQ3v8opN73y100qbMnp8XJ2rSHh069P0TQhMXYBgr2PaEsGGZ7riSyPMhewAP40Q8qA/Lc6U5n7lQ8dSrMci9k0ggf5VngEy+a6Vf3NwoUUiXLSvmBfvgAqU3fYKYK10kACClzW4bzL6/boJIwGPsKrMEQr4fpEe8S5O+HF3FGucdWmTj408vB7UspzKuCsYZsUSVhIU5Xv8Q9C+ofYlu7GvjojMi0PilqgnhxWwZ1QWiR/PhWJXS42ZO2BgRcAL+6hPjJRrmaEGdBkxgcJ4qRm64Lp/Totzb3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(83380400001)(2906002)(31686004)(2616005)(6506007)(76116006)(66556008)(41300700001)(66946007)(91956017)(31696002)(86362001)(36756003)(66446008)(38100700002)(122000001)(53546011)(54906003)(110136005)(4326008)(82960400001)(38070700005)(66476007)(8936002)(8676002)(64756008)(5660300002)(186003)(6512007)(71200400001)(6486002)(26005)(316002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUExNndDUzRaUE94MWlmelpFWmtZWTMrYTBoSExWSElnejBxbWx6MEFNeXYy?=
 =?utf-8?B?Q2pBcjJSR2xmdmFXdWp0NzhQM2htZ0xmRzVCblR5WHdXb0d6a0VmcEpGK29L?=
 =?utf-8?B?WFVSb3FYTVJqMWNWRytPT1Zjd0tiZnpRMXVPSSsyT1VSTFBJYTREbGxIZXdM?=
 =?utf-8?B?QktNNnExN2d1dU5ndmo4RmU0Y09ja21vcERJM0grbGliZ29NKzNrQ3dqS2hO?=
 =?utf-8?B?TXY2YmQ5TWtaQUR0M0Rsd0p2TGQvbWYyNHRybzR6dmZlb3EzVDZMRUN4eW5H?=
 =?utf-8?B?RXF3c3FuMzF2M3lWcUdnbjh1TGJXM3p2N0tvN0g2cUtScVlkU1ROVGlkMVhY?=
 =?utf-8?B?US9KbjJMSGhCd0V1L0F5UXZuNi81ZG9zcXBzcm9mMXRtOVJhZXNUbHZSemVv?=
 =?utf-8?B?alpZT2tabzVid2hkNnFSZFdqYlkyUG5nZ0pyeWZkZElQeXZSYkY4b2o3elBo?=
 =?utf-8?B?dGJaa3hWNXVLZDBKZGFkVVFGR3dwRFZ4cTIxeWxjeEFnNkpQN0xiQVRRMnlN?=
 =?utf-8?B?Si91ejBzTXN6dVNaMEtGQzlFbkFaRFZRUHB0T3Q4WGs0ak1YSS84R0crV3dW?=
 =?utf-8?B?SDJMMkpHcGlHVGhSQk56WFAvUkRINGg3U1lQZno4bmoxc0ZzQkNwYzZoUFVw?=
 =?utf-8?B?RDhYczJDazFEbVFGK3pYMHhHN3dzRG5Qdnh5dkttQkZqaVpJNUZiaUpjdTU3?=
 =?utf-8?B?Q0t0c0xORHRNR2ZnWXBSRHpJWTZnSkNMNFdCaktQWjJQelQ5VElCbnArWm5Z?=
 =?utf-8?B?UmVGL2t6L1pRSGxEQitxMDJSQ2VtbWp0Z3V2VUZSeHJ2d011TUdlQWNHOHFW?=
 =?utf-8?B?V3ZTUHJzVTRXMDZPNmxKOVZkSkRvQXAwYnU5T01JNWdSeEcxUUcrVlpBYnpO?=
 =?utf-8?B?SXN2L01TcGRHQktsNFVTSWJnWjZvY2lzblV1ZzRZL0JYeW9hM1F3ODFWSTg1?=
 =?utf-8?B?KzhOb3Uza25JY0JBczNmNUt3Q2FNRFA4eWRqVVFYSk5JSHcwNk8yQ3l6Q21D?=
 =?utf-8?B?N3p1MmNRTnVyS1NCOEV5Q2Jhcy9LT01PMVdTODU4WFp5VkQ4TDF4dHpxQ3Y4?=
 =?utf-8?B?aVc0S2JGSVhBRExkV2diTzdPQU0rR3JETEJzZy9YcGZ3OFRjZDQxYUNCY2Nw?=
 =?utf-8?B?RTlNS1NiU0VuejZQa2xZaGIvdFZWeTNudUEyU3dlYVBDU3ViUHdodXo3Rysz?=
 =?utf-8?B?dXhzb2cyelJPL1ZRcXAzSHZ6S282Y1JCYnJ5RE1lanlmcVoyeHVaRjg4YjdH?=
 =?utf-8?B?cFRNYzdnbDVKdFR1K29SMVVQQXJhaVJQK0JhSnFhWHNydTFIaHhObXhSOUtO?=
 =?utf-8?B?eEx6VHNYNmtIR1NLNGFpOERuVGxiMFpIdnRTdDVqalkzcmNUa1pMR0FCd2RP?=
 =?utf-8?B?eU5QQTdRMXgxWmhrVmZxaGdoZnV2ZDlMbkVFMzFCYWVBZDlvUjJoN2haM0Fp?=
 =?utf-8?B?WUQvSm9Cb1lid3dLQXM2NFFoNWt4SERPS0FPYnBtOXduWWVQektwdDRoY3hl?=
 =?utf-8?B?QklJUmc0d2ZSQlVMcXZJTkNjL0dpdGU0dlhYNXJsUTFRUWFZQVBmVEozYVVF?=
 =?utf-8?B?Yi90MHpzYjVDUVRPeDBVOW1ZMjY3R0xnNjVHYzJiZWFjR1NFVE5ZNUtlc3pt?=
 =?utf-8?B?dDAvQkswc3A0L0piUWVqOWxJSmt0S3hqWnhScVNVTTBsZWRtMXI1WFcvYVJi?=
 =?utf-8?B?ZHpMZXY5Vk1xb1dML1N0L3diQmpsei92MkxhaHFOWGdhVkJDTjJoaUxSNXNy?=
 =?utf-8?B?NDN6bG1NbGVNZFJEY3ordW1XMGlwSkJjL3doWjNSMlFTV2JnYUkzb1FXTmhK?=
 =?utf-8?B?ODlTNmowKzN2M3FURm1MTXVpeUVyMXFiRTk5TGNKeHhJS1BjQ01MRXhuSU1R?=
 =?utf-8?B?eGpHbW1aS0hqRkJOUHRCaHV5b0xYRUsrTmpsU3RWQVN1bWY2WXhwYjlrdndE?=
 =?utf-8?B?MkRYQmFidmNzeThTNTBrMkVVMEtKZGF4dFN0UHlCbW5SQW1GTDFqTnYveFYr?=
 =?utf-8?B?SjJldXNyNUZmVUlqWjh2M3ZIOW1mOEFMWmNhOXJ6Yk4zOVAyVnlXYzVkSVho?=
 =?utf-8?B?VnZycitnYzd0bGZ2OUI3aml4RDBxNUhaUS9lRFkyd212NXNZSkN1bE8yMWtM?=
 =?utf-8?B?eW42am9jdUhiQlczSHMwRWJ5cDIvdFN2M1RFOXdqZCtGU05TN3B0YUR0NCtz?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31A03E41E9E2CB4EBAD470A56C8B39A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RjBhV3JmZVhlZThtalRwMHJ0TFVHY1BMbGNPZi9ua0E5UXBrN2tYc29DSzFR?=
 =?utf-8?B?TG9EQ0JVUGM1WEdkODhYWFQ5Y2RjVnZsR0dNMnpwOUVsREtZLytwVDhYcnky?=
 =?utf-8?B?UzZvVkVCeVhYVW1tbEJ1dVNSMytlSWM5blFIS3h4KzVFRysrMkd2Sk1iUTBG?=
 =?utf-8?B?Tk1TUzlqRi8zeEdYbWVoZEpDQmZnelViU2FtV1VVamU4MHRUYThNU2Z1ZklC?=
 =?utf-8?B?akpCQTBDempLSytSZ2xOOTlISEJTWUQ0L0NJQ0Zyc25rMmhwbjMxMUxRTHpo?=
 =?utf-8?B?MDg3SWpVQmRpb0F3dmJsNWdtZ0ZJaVFQY3VqdTZQL0l4STZYa1BueWtGdnI2?=
 =?utf-8?B?NmVIa1hXZHlLYmNvQk5SYzYyZzVxS282ZnU4bVFtbXF4QnRpb2hzS1RZWnFC?=
 =?utf-8?B?YnIzd3hpV2pPUG9IUDJNdG5NQmdPNTExcXQvb1g2cVVKaUVralVrek1xcURn?=
 =?utf-8?B?dmpsdjF3bEp6L1FKeERxUUxHNDA0dWhac1hNS0tkcUVqajgwUXNJcEsxbS90?=
 =?utf-8?B?dWI5TGFoSmFrQVVRdEd5MlY2aUpybnAybEMvYWRxdm96YzRDdVVxQitMWFZZ?=
 =?utf-8?B?NERjK1gxUThLWVgxRnFHNWZBY1E5ZjBsQXhselovc3Y0R2ZYU3NUb3pzK04w?=
 =?utf-8?B?ZXFXUzdvZm1nZHpmRlJCMitmUkV2cXk3aEhteURhWnlwcnZzbk9GaUlCQUI0?=
 =?utf-8?B?dVY5UnFRRTF2NVc1NzFuYkdib2FDc1E0ejl4NEtFRkF5eE5hUC9YWWx5dmY3?=
 =?utf-8?B?MEpNTHg3dDNmSVBTOFJ4M2d5TXd6OW1yeHFyOGJTOFV0SmIwUWFRWFY0YXgv?=
 =?utf-8?B?WkZFN2ErVjVERWF2Ums1a001bEx3NzdNeUxuWHpJbnB6aWlZT2FNL1Jrcitu?=
 =?utf-8?B?RDRCbFNtVGlaOSsrMVlyTUNNS0pvM2tJdmw0cm5TUmxMeEYyZE1XM2hyOXp3?=
 =?utf-8?B?YktHdFVYRVBvdENxL01rVm5vV01YRXgxbXVGUzNSemljQnhTbFozTlVOQTJC?=
 =?utf-8?B?YWJBZDJZVWdwajdjWW5xNGJHL0pFbkdaOFREZHBuQndSRGx6dUx6TTBiR25B?=
 =?utf-8?B?Z3Y4MFZqZ3l3aE04K3oyd0M3b3ZOdWpnRzBwSHVDSVNqejMvZmpXUUEyaHFQ?=
 =?utf-8?B?MzVFcFFzclNUSHUzMHhkakM1N2xpWmQ2R3pPVkdvSGV2QjVqUEg4TC9zMU93?=
 =?utf-8?B?a0phV0ZLNmtOeFRvM2NodmVsbDZId1RsRHZjMDhFRlhUUWpmeE05RkJqMGdy?=
 =?utf-8?B?MFlQeURJS3o2T3Z2cTcyaFZKc0c1SVVCc1Q4ZEpDY0toKzBRNTVMSEl2SXpE?=
 =?utf-8?B?VzA4T0M2aHV4bEZOU0x6MFJwc3VGZjBoMkxJWE5EMGo0SWJrd0Z6NE1CT2pZ?=
 =?utf-8?Q?Up+cstuMhyummcUkSDVpegmc3kSb3PLI=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71fba21-7a24-4140-1277-08dacc5d8064
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 07:45:18.3944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZSHsmHKaqnqx559ZNWfPm88ucEkXHpTojppoHMx4z1GKSnznJPV5rA6qhnRYNeOv3Dinle/49gD3E1IWiqazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3927
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS8yMiAxNjozMywgUGVuZyBaaGFuZyB3cm90ZToNCj4gRnJvbTogWmhhbmdQZW5n
IDx6aGFuZ3BlbmczNjJAaHVhd2VpLmNvbT4NCj4gDQo+IFNpbmNlIGZvcl9lYWNoX2F2YWlsYWJs
ZV9jaGlsZF9vZl9ub2RlKCkgd2lsbCBpbmNyZWFzZSB0aGUgcmVmY291bnQgb2YNCj4gbm9kZSwg
d2UgbmVlZCB0byBjYWxsIG9mX25vZGVfcHV0KCkgbWFudWFsbHkgd2hlbiBicmVha2luZyBvdXQg
b2YgdGhlDQo+IGl0ZXJhdGlvbi4NCj4gDQo+IEZpeGVzOiBkNGMzNGQwOWFiMDMgKCJwaW5jdHJs
OiBBZGQgUklTQy1WIENhbmFhbiBLZW5kcnl0ZSBLMjEwIEZQSU9BIGRyaXZlciIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFpoYW5nUGVuZyA8emhhbmdwZW5nMzYyQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtazIxMC5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9waW5jdHJsL3BpbmN0cmwtazIxMC5jIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtazIx
MC5jDQo+IGluZGV4IGVjYWI2YmY2M2RjNi4uYWQ0ZGI5OTA5NGE3IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3BpbmN0cmwvcGluY3RybC1rMjEwLmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL3Bp
bmN0cmwtazIxMC5jDQo+IEBAIC04NjIsOCArODYyLDEwIEBAIHN0YXRpYyBpbnQgazIxMF9waW5j
dHJsX2R0X25vZGVfdG9fbWFwKHN0cnVjdCBwaW5jdHJsX2RldiAqcGN0bGRldiwNCj4gIAlmb3Jf
ZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZShucF9jb25maWcsIG5wKSB7DQo+ICAJCXJldCA9
IGsyMTBfcGluY3RybF9kdF9zdWJub2RlX3RvX21hcChwY3RsZGV2LCBucCwgbWFwLA0KPiAgCQkJ
CQkJICAgICAmcmVzZXJ2ZWRfbWFwcywgbnVtX21hcHMpOw0KPiAtCQlpZiAocmV0IDwgMCkNCj4g
KwkJaWYgKHJldCA8IDApIHsNCj4gKwkJCW9mX25vZGVfcHV0KG5wKTsNCj4gIAkJCWdvdG8gZXJy
Ow0KPiArCQl9DQo+ICAJfQ0KPiAgCXJldHVybiAwOw0KPiAgDQoNClJldmlld2VkLWJ5OiBEYW1p
ZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+DQoNCi0tIA0KRGFt
aWVuIExlIE1vYWwNCldlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA0KDQo=
