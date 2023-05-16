Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439EA7044CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjEPFpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEPFpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:45:32 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E4C35A0;
        Mon, 15 May 2023 22:45:31 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G4s9pr006065;
        Mon, 15 May 2023 22:45:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=XEzOVeykAFsewFHW4UUJShx8DAF8Ov/gkQ4mR9EArP4=;
 b=d8XsUYWYDyfWUW+4O+wkk8vk02mAvhySKP4o0WtEq8H00k8Ph9DLmSG74bDGWTLYwlBp
 frsCK/DkFjew9Xeh7qBZJ+fiIZjCWG+FLxkOADwnil2WZGI4kZ8FxUreVBpcnldRJZmn
 ReyDoXa2MsMxH1jXQQQ2EV0eFE77hrIudFZR+GR11btqz/BvrB4AZvr1bA8j+6o64HoQ
 GreGM6sqtCOZKK/fpQJLztCdpwCt78INdbc9f6gBK27kuJUqiQWx9qqPv399lPwAyYzH
 /Fwk8dft3lTMTSy/PkRsMDBIITj2NXWvCEL1Ev7VsAf2BxIl/CIsYOXM0J+afjMAFqg9 pA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3qj96eccyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 22:45:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684215923; bh=XEzOVeykAFsewFHW4UUJShx8DAF8Ov/gkQ4mR9EArP4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iw6RReWFqDMhKzCLh/MqBM1MXndnmyHNz6ZV0wk2H0Av8owNXSZZDgWaPl+SdGQv8
         YEE3dVyKha6wFyWJuh+SdbvTIxGx0uYP1yd5I5OeQd98tVHyNwuU4+et26r3C9bzea
         SCjUQHHjKoK1uFLbk1wy+IggRpxwCnaxa0z6ri37XD3fZIFPUCfz1mdDpwlXux+M3C
         iM0pLzXKa8VZvh9dqUh7e/KYkaAr2MHo693WzPygdJPjPVgvfQTePblbdk+bcTqYNy
         LHPSByFBe+FkEjRa3UJvMQBEPKEwe3KUrYUB1BDxS9hc3GCcB121zfrG1eH//ymk/v
         d8NOiSeG+dgUQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F1A74404A8;
        Tue, 16 May 2023 05:45:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 36BFFA007F;
        Tue, 16 May 2023 05:45:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kGKSTvhL;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 75F4C4063E;
        Tue, 16 May 2023 05:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCV71sBIkOwDvb4shFbC3S3NHDG/OZ5fyjmtebEQCMUE1C4DVfpm89pbfq0sR3wVApokqigCoY5ob7wpSyBu2Kmz4f6hXUGwptMMbkVYhYwQEVZbmiKTDRZHJfcb6lW1p+WLaqCzTvWAXYbXsNYq28zZppO4Kc4kVImTQkFxrMJ1tfLoAuGAnOckqb9xSSvPFJEYrUF1b94v6dH9B8CjCHCahkmMOlLXtV+Zrqb4cTWeFUL4YHeEyrHspnc8zgZY4irJ2170JI6ZoTkz3Eac8CeqtMuAq/B+Ke00FGjsu37CouYbBP9jgJlNhlZ2RcjCL9BKF3vbzsxXYqj/1YDgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEzOVeykAFsewFHW4UUJShx8DAF8Ov/gkQ4mR9EArP4=;
 b=WBljleNVmi/Xl3rfstq0qOO3bKzm4u2q/yqgVPfFAfyHRCcVqNlBnQVfklg/6xJE1aQn6R9+FY02WTI/LDrWfBHe4+nTYn0MWYtsdbmo5GMtkD1WLCZCOdjK3OsR2zoda2EB05djlpKleFYsNFsbZXIOuUqwM2S0tfhHTzAB06aMp/0sAh+KuYKwMR8Cvi2ARIkJAaECC7C3pPR3KMgj7DQIHHZLshsVh73GilJ8IEjPMd9cZKTQ+NfQCoyPlhN4nVkvDVAGVH60gW2Z2VO6j+1oyYlnvNWt/4VGRWvaAUHFhuOOXjTx7yaCZt3oYkLuVA+DemB0qcCsZNiLdeukyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEzOVeykAFsewFHW4UUJShx8DAF8Ov/gkQ4mR9EArP4=;
 b=kGKSTvhLhnAUWcOejUUpaZxoYXabyisp1zUYS2aUE6aaLhxyqbe8H6UnXB4skRU6LkKNP2wW+grrGnYJwaCisiT8oZoWDiqiNU/UqchWbQfNU8NOFfDDBIBjiWNJx6ZMMjG+A7HQ8hjkYjV9cYRw60RFccl2rIkCN20DzbesmI0=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Tue, 16 May
 2023 05:45:13 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::788d:db33:93b1:53f8]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::788d:db33:93b1:53f8%4]) with mapi id 15.20.6387.029; Tue, 16 May 2023
 05:45:12 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        John Youn <John.Youn@synopsys.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Fix some error handling paths
Thread-Topic: [PATCH] usb: dwc2: Fix some error handling paths
Thread-Index: AQHZf3Uterps0wid9kuC3VtptRQTE69cdDwA
Date:   Tue, 16 May 2023 05:45:12 +0000
Message-ID: <2ebd0eaa-a633-f901-6cc1-ac5504aef334@synopsys.com>
References: <c64537b5339342bd00f7c2152b8fc23792b9f95a.1683306479.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c64537b5339342bd00f7c2152b8fc23792b9f95a.1683306479.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|DM6PR12MB4578:EE_
x-ms-office365-filtering-correlation-id: 42c2039d-275b-4a2d-eb8e-08db55d0b764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVTjtHnTAKPDJmKXcx9WRGqm3nQ2tu1sIhbpD9rgVB/U3bC6i71O84QnSc0CxiqRJDtkXqeTrIdgcTk40vYfnzAIJ1gJgd4iZDHxPM8rWN2Pew51p0d9vaDgjQ4LZ9JCg5B8eBTtSVG1TcPq6W9C1YdtT0sQw8de3Eyyi3J5y6eDFXVrCuCx3241Tu8ad5OhwXjC8bByATZcK6YntP0MvhQqAcTrimmesLMIITIYiqp+yUCqPPWsjlwZzLRYKrQ0S6Er0eVElnEi0u0cZcEf9N/fdzUaOmXsLzvhSYhh50uUPUsRtqpBBL6HTDetCPFzSHXKLkzcw0fYi4omhHbOsIfA1SAvrQcdKp/U7MiSR/gRRz+HQKD/5RF3PzVbzCU5aagmoctaESQZrGzpbgYxMFRV66RAP0IyzzDu4NOi363vLGSUPJTP5Kia0uJeOytBQJxbyqeq/iLnxDdVFhi34zZKYf+U7hW1JlD1G4GlEr4UhwYWvaXPj9ckcFIbvYP7YkCgk+ELgE+W1AH7MJwL3O8pVvxVrNWyRsGAGPZoFIWk5tqdGViNJqm+LVzwElDUM09OQE7ZqV4paNq8VnDy82zvQEWsRXwN9ZqC2DJ2a4xmD2C5YiUIPkdCuxDrUP9bg7tU7GJn/V1FbvlM/W3GhqjnnlMSkW40pSWC6HEHfB9b0nVN5Espq5Lc8V3KJlJh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(36756003)(91956017)(316002)(110136005)(6486002)(54906003)(66446008)(66946007)(66556008)(76116006)(64756008)(4326008)(478600001)(66476007)(122000001)(8676002)(8936002)(5660300002)(86362001)(2906002)(38100700002)(71200400001)(31696002)(38070700005)(2616005)(26005)(6506007)(53546011)(6512007)(83380400001)(186003)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTF1S0gvSDMrNHhNRDZ1QWdJUlcwOTlQRWRYSVEvT3RUa2VnVk1tbTI0WXZS?=
 =?utf-8?B?L25sQVloOS9lZzBNUEZ4Nzk2dTVEbU5IcTIrd0Z0WkF6czc4cFp3dGRCMUhn?=
 =?utf-8?B?dFEvZGdWWHdaTjUwRFg0YXNlVkxBL2VHTUZCUDdtSXZDWGp2V3dlVDRLVCt6?=
 =?utf-8?B?TXYvakM4d29YZ1BQQlFqdjl4SXdrM202Rmo2K0NzczF0dm14bkw0bkp0bTQ3?=
 =?utf-8?B?NWVoMmdZWXZwVU9wOVZoNzlVUGpxMHF0ZkFPcENKeXM4aXJpWHVrK1phS2hP?=
 =?utf-8?B?eVNSZGs2MHc2cWh4WGVWLzNxZWdWdnJTN1NIa0hzTVNVdU1qditGRGlBSG1v?=
 =?utf-8?B?YlpKRzlqdTVla0ZETFFCVkZRQXEwUk9COXVRK25XZmQ4TWtURFNGUjFwY3RT?=
 =?utf-8?B?MEg5aVN4TGZlekY3eTRaRm55MHlzSXV2Y2QrZ1l3K3Y2VUtqbWU5c3ZKZEdp?=
 =?utf-8?B?NWdJRmx0S2JJQTc2SW5OOWg3Nk9nVU5rbS9Nd2szZ3FyK094cWxaZlYrcnlF?=
 =?utf-8?B?eDgwSlRMalJUcjNmOHdrdmxuQ3cwaDJxa3hGZlk2RHNEK1RrbFV4Qk9IUXQy?=
 =?utf-8?B?Rms4c1ljQzNLM09ReGpHeFQ5TW42WC9RMWlSSXJKZDRjV2VjYjYyQlFEcUdk?=
 =?utf-8?B?K3BUMXV0TjFrdkdKRDZWQ0JJdWs1a3Yrb1pGTkUvYm9iSDFVb1o5ZHZTV3di?=
 =?utf-8?B?L2pEN0F1NzJOYnc3ZTkrbkYvWmgzNmFmVXpyb1BRRDY2Ump3VDlSK2pCVVNt?=
 =?utf-8?B?MndDbUpLY1pWb094ZjAyTGxFSXlVaklJUkdUYTdGTVAxbDNhVTZXdnI5ckR1?=
 =?utf-8?B?b2czQVhrY0JkbWtibzZvdmo3ZkZnOGMzem9BU2pSTzRpK254NDM4UWxxNmtj?=
 =?utf-8?B?Y1pEWjNGUUMwcGhVNitXQlM4N1VQQVJrTHBOVjJNcEd4dXdpcUNzZ0NOY3Er?=
 =?utf-8?B?bVduTUJTWU4zRFpOdG9mTWx1ZTlzM1ZZWjNhV2p2SFJZVlpHY0xzMVFoS3Vv?=
 =?utf-8?B?MmxtWDBsMzdYZVNVZlNqM0Y2RHVZK3RYM0ZyQVRoTFFlNU9QdC9oSW56Unlu?=
 =?utf-8?B?dWNRdy9FL1VEc0dwSHVIQkhiS0ttenZmei9zeDV3Rm01SEppN0VRczBCYmh2?=
 =?utf-8?B?ckRWTktYSENyMEtMZnA5WVk5RXZUS3NCVVNvSW8xaVZDNDM2SXZpRmNjR093?=
 =?utf-8?B?U3BqNTgyY3p4TktNa2VUMERROGhGMmU0NXFyTnNHSStQRzZBL3NzY04rZE9J?=
 =?utf-8?B?d3BmQ2UrZDBRVzN3NktkRmhySlFxSGQ0Z0E2NDY5UW1kbzFPN0ZDc25pSmx5?=
 =?utf-8?B?YlpqSC9LZHJndFp1R1VxZ3RNTHZnNXlkOFU3Si90eUkxQmJpQkpkMGJSS1NP?=
 =?utf-8?B?d04rL2l5MFFvUnZGMXg3TmJoMVRhY1BoZkx0MU03Z0FUNWlMTGRMbXVYV0ZG?=
 =?utf-8?B?VjdkZEs1WnFLcEdQUkhyVXh5MmNOSkpGRFBnT1BHTllWTkdWWXRKS1VCeFpV?=
 =?utf-8?B?MG5JWHNxczFZMlMvU2NnRCs0Y3BJQ1o0b25tdUlESW4vVWhkZ213VXFsRUdC?=
 =?utf-8?B?bU9pK0E0TTliL0dkcDcrMURxNnVTaWRHSmdKNDRiQlJqdGNja1FybFZDa0cw?=
 =?utf-8?B?N3NUVjRKbDh6Q1FpQlJIR0EyNjVFSTNqaldaV1FQQ3g0K0xscTZWclp1ZzVB?=
 =?utf-8?B?bXpFd3doTWQ5M2dHVFdqZ0x3UXFPeU5RcGEvM2puN2dnR1lIWVlQQkJtbTNP?=
 =?utf-8?B?L0pxMkMzSnJnLzRYMGRuaXdLZmpvYm5HMmowRG95ZFJDNGU1MEdBMHNERmhL?=
 =?utf-8?B?SGVNTk1NQ2tGKzBaaE5EdnAxUk1ETnJTQ2IxUFRXNDl0Qmg1UDF3ZllLNm5M?=
 =?utf-8?B?dE1xbkRwdzloS2JXaERYSzgxOXZSa1M2WTBvNlEwbkgwSU11ZlV6UGdoZ0ZJ?=
 =?utf-8?B?d05VZWUxNzBOVWxjb09mVkpnckVRemM3TjF1bGc1Z0QxMm9qNDB3R3JPSnVO?=
 =?utf-8?B?empuY1RQRFpDZUVCMlIyUUJMU0VYdVI0ZE13ZnN1cXNBVnRiNzRqRDZQNVpm?=
 =?utf-8?B?NHNrY1RaVUVjUDZSSlByNWg3MVVSTWF3RERsSUFjZWRhVHZnT1k1SmNOOWY1?=
 =?utf-8?Q?kjiVgrPkZQCM1wKlG5+B5BQtx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF95A8CE8FECC24EA134757DAE1CF4A7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RUJWS0RBdU1JVmtmQ2k5UHkySVpiZEZsWmpQakdkNzRQOEU1ajg5dGR4WCtG?=
 =?utf-8?B?b2lJbnRPeTBJZFBNSmxJVmVRQThHTUgxQVhXcjlGcENIVGtKcnpOUmo3UkNY?=
 =?utf-8?B?dkY5UHhSSXg1STFCM2x2OWJyUWNDRElxZTJETVpIOXBCcEc5b0wwaGc5bWVw?=
 =?utf-8?B?cUxBTHJiaWpyTXV4bHZhRmZ5b1dRdm81L3YrbGR4YTlWazFIay9vSDVtT3pi?=
 =?utf-8?B?SmthRGhGT3VqZGt3azBRcUJMay90cGx4WjUvZFRqZ0ZVaVZTTTIzWDJVS014?=
 =?utf-8?B?blBhdHM0a3hyZE01TVI4NXZHcHVZZzJzSTQwRVczQ1lLZTJ0NVFTZE80VzZF?=
 =?utf-8?B?SkdiZXNvc2hwZVgrU1lGZElqci9nR2RvNEdmalp5WHFsSUdSN1Jocm00QWNh?=
 =?utf-8?B?V0QxTklPUUhPRlpQaFR2VzFscUptWkNSRmx1UEt3UHRxY1I5VThYQ0VSQ3cv?=
 =?utf-8?B?QU41enNNRVRudkFNOHUyNmx3bmM0aDZ0bHdBQXVIcEtNZ1pPcDBtWFJCTXJw?=
 =?utf-8?B?N3p6SEQ0c2p1M3IvNStLa0ZUWXlqR0NXaVMyOXFoc3Q1ejJLRzByaVUwUmpl?=
 =?utf-8?B?a0RocXJCUWYxMmNpd1d1d1dMU25menJjY1AyRGZVUlgrMlJOVUF0Zk9OSXdJ?=
 =?utf-8?B?Rzc4Y2xyL3VzTkExU2VpQTY2NEIzM1JkbmdJS0p1RURZQ2JNZ2s4MUt1aFQ2?=
 =?utf-8?B?R0FTd2txbUxlZG1hZUFsL21hTStWdEpxdjB2dC9od0l5MGY1a1lZYWMwRHZq?=
 =?utf-8?B?UXpicWNXdnN5RVlmQXhERzF6ajBmSDU3SjlzUjNBQXljYVdKb0V5NGV6REs0?=
 =?utf-8?B?UFpkOGVoUjNubTVoQ2hzWnBtaktOT2NZWklUa3NKMmxmNXhGREljR0Fta2Fr?=
 =?utf-8?B?T1c4bmdLS2ZWb0dYSlR2d2xhSGRJajN1WVdUVDNxU3hWZ1RHRFQ2S3Z2UTVy?=
 =?utf-8?B?UnlORUVjdDFIQjVQc1FhQ08yVmFDMzBQd3I4bDcyK1hwNDZxK1RoaFo0SVlJ?=
 =?utf-8?B?bjY2bEM2TGhvTCtaWk5hVE54N3VoeVUwM2tTM01FdzBEUW8yWjZuMmEvblow?=
 =?utf-8?B?OXB5RkNLVHpENk1rL0JLODVoZi8rUE5qQkI5aGlVVXY4RG9hTTFqVE8ydVFo?=
 =?utf-8?B?UzJKVXB0bzNnYmk1VUlwRkFybWRiQ0IzZFU3YTY2d05ZR3kvb29NeDhPc2hl?=
 =?utf-8?B?ZldsMG10a0xIb3ZJQ0g3bm5Dank0ZkhIWFNCYlRSNmRjaGkrWG5hYXR4S2lV?=
 =?utf-8?B?SHVac3gyS2U3R0h0VXcwU2k3TDlieUhQZ3EydjZsakFORmZSdz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c2039d-275b-4a2d-eb8e-08db55d0b764
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 05:45:12.1419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PD3qb/HW2fb5nS/zrjGpmiidR+dNAM7lWikEIas2dZHBjwWKCDH9LHtSY2teznztZ3kY2nGOyaj+7DSYZ3vQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
X-Proofpoint-GUID: s5NwQh9LL9vr3N87B9ZsRqwlJp1O68JC
X-Proofpoint-ORIG-GUID: s5NwQh9LL9vr3N87B9ZsRqwlJp1O68JC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305160048
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDUvNS8yMyAyMToxNSwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBkd2MyX2Ry
aXZlcl9wcm9iZSgpIGNhbGxzIGR3YzJfbG93bGV2ZWxfaHdfaW5pdCgpIHdoaWNoIGRlYXNzZXJ0
IHNvbWUgcmVzZXQNCj4gbGluZXMuDQo+IFNob3VsZCBhbiBlcnJvciBoYXBwZW4gaW4gZHdjMl9s
b3dsZXZlbF9od19pbml0KCkgYWZ0ZXIgY2FsbGluZw0KPiByZXNldF9jb250cm9sX2RlYXNzZXJ0
KCkgb3IgaW4gdGhlIHByb2JlIGFmdGVyIGNhbGxpbmcNCj4gZHdjMl9sb3dsZXZlbF9od19pbml0
KCksIHRoZSByZXNldCBsaW5lcyByZW1haW4gZGVhc3NlcnRlZC4NCj4gDQo+IEFkZCBzb21lIGRl
dm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIGNhbGxzIHRvIHJlLWFzc2VydCB0aGUgbGluZXMgaWYg
bmVlZGVkLg0KPiANCj4gVXBkYXRlIHRoZSByZW1vdmUgZnVuY3Rpb24gYWNjb3JkaW5nbHkuDQo+
IA0KPiBUaGlzIGNoYW5nZSBpcyBjb21waWxlLXRlc3RlZCBvbmx5Lg0KPiANCj4gRml4ZXM6IDgz
ZjhkYTU2MmY4YiAoInVzYjogZHdjMjogQWRkIHJlc2V0IGNvbnRyb2wgdG8gZHdjMiIpDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFk
b28uZnI+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5A
c3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYyB8
IDE2ICsrKysrKysrKysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL3Bs
YXRmb3JtLmMgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gaW5kZXggNWFlZTI4NDAx
OGMwLi41Y2YwMjU1MTFjY2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZv
cm0uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gQEAgLTIwMyw2ICsy
MDMsMTEgQEAgaW50IGR3YzJfbG93bGV2ZWxfaHdfZGlzYWJsZShzdHJ1Y3QgZHdjMl9oc290ZyAq
aHNvdGcpDQo+ICAgCXJldHVybiByZXQ7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIHZvaWQgZHdj
Ml9yZXNldF9jb250cm9sX2Fzc2VydCh2b2lkICpkYXRhKQ0KPiArew0KPiArCXJlc2V0X2NvbnRy
b2xfYXNzZXJ0KGRhdGEpOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCBkd2MyX2xvd2xldmVs
X2h3X2luaXQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIHsNCj4gICAJaW50IGksIHJl
dDsNCj4gQEAgLTIxMyw2ICsyMTgsMTAgQEAgc3RhdGljIGludCBkd2MyX2xvd2xldmVsX2h3X2lu
aXQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIAkJCQkgICAgICJlcnJvciBnZXR0aW5n
IHJlc2V0IGNvbnRyb2xcbiIpOw0KPiAgIA0KPiAgIAlyZXNldF9jb250cm9sX2RlYXNzZXJ0KGhz
b3RnLT5yZXNldCk7DQo+ICsJcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGhzb3RnLT5k
ZXYsIGR3YzJfcmVzZXRfY29udHJvbF9hc3NlcnQsDQo+ICsJCQkJICAgICAgIGhzb3RnLT5yZXNl
dCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gICANCj4gICAJaHNvdGctPnJl
c2V0X2VjYyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWwoaHNvdGctPmRldiwgImR3
YzItZWNjIik7DQo+ICAgCWlmIChJU19FUlIoaHNvdGctPnJlc2V0X2VjYykpDQo+IEBAIC0yMjAs
NiArMjI5LDEwIEBAIHN0YXRpYyBpbnQgZHdjMl9sb3dsZXZlbF9od19pbml0KHN0cnVjdCBkd2My
X2hzb3RnICpoc290ZykNCj4gICAJCQkJICAgICAiZXJyb3IgZ2V0dGluZyByZXNldCBjb250cm9s
IGZvciBlY2NcbiIpOw0KPiAgIA0KPiAgIAlyZXNldF9jb250cm9sX2RlYXNzZXJ0KGhzb3RnLT5y
ZXNldF9lY2MpOw0KPiArCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChoc290Zy0+ZGV2
LCBkd2MyX3Jlc2V0X2NvbnRyb2xfYXNzZXJ0LA0KPiArCQkJCSAgICAgICBoc290Zy0+cmVzZXRf
ZWNjKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgIA0KPiAgIAkvKg0KPiAg
IAkgKiBBdHRlbXB0IHRvIGZpbmQgYSBnZW5lcmljIFBIWSwgdGhlbiBsb29rIGZvciBhbiBvbGQg
c3R5bGUNCj4gQEAgLTMzOSw5ICszNTIsNiBAQCBzdGF0aWMgaW50IGR3YzJfZHJpdmVyX3JlbW92
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQo+ICAgCWlmIChoc290Zy0+bGxfaHdfZW5h
YmxlZCkNCj4gICAJCWR3YzJfbG93bGV2ZWxfaHdfZGlzYWJsZShoc290Zyk7DQo+ICAgDQo+IC0J
cmVzZXRfY29udHJvbF9hc3NlcnQoaHNvdGctPnJlc2V0KTsNCj4gLQlyZXNldF9jb250cm9sX2Fz
c2VydChoc290Zy0+cmVzZXRfZWNjKTsNCj4gLQ0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+ICAg
