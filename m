Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207106CCC11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjC1VVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjC1VV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:21:27 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB31BC8;
        Tue, 28 Mar 2023 14:21:26 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SIUIJv023839;
        Tue, 28 Mar 2023 14:20:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=9P+pRt+QgN8rjRApKXyr1rVmLrCyztysoEUbCdjFI/Q=;
 b=sseO7mFhvjw074qyBU/nqZHho6Wjdd+qW4gtu1kQ8cb6hTmuMxVEveAJjpivWNTiPfMf
 bB8E6gi2sqVcFWjh+hKyCgowNHHPzyXZFduS6KjTNXxxMTAdCfRuJNdZ5BUKTzcWiz5D
 6CxokWiiTnEPzrgDsbqp/wbCNCrlUvyt+Bjc307NH7NskBRAP4Tsz7+48irSn8hgZgo6
 xry+BDib2JPtwhoFZQcIbAa6zyys/TvTofrtWBsITQuDYHoeCPHF9ulEtUsHEGovm0NP
 ra0sLaL2eROObHzWju/L7YxtHGt9FLbNhYjzaL/SYfTEmPGaIm6RzhtLQ1QcFXbKTC7F HQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pj076qg17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 14:20:58 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7209340020;
        Tue, 28 Mar 2023 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680038458; bh=9P+pRt+QgN8rjRApKXyr1rVmLrCyztysoEUbCdjFI/Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=U1qeJJc+QJqnj+AFvXsxDK6g4oeLOw7QZv3EWg76PsTW02LEUDnHu8+eQKWK8Oc3U
         9QlJ269fbshtqo/r3s018YIZGOgJPkqtJxmTn2JjbxaL2EUgg1/0m5H339iVdgxZAe
         WH4wMN0Dwfg72ufX+9Di02OtVm8C+Sv80vZBP9riYs+KNLHyXGejzhudrdKevTdtf0
         9q3oHovoUDv6xTFRp7l8fWe17KekOtUpenssq7PXc1cQUz0BzpD8JC2sebxO+T9C18
         1mZ+fHgp6IcSGhbUEYIExmgXOJzqUVVE1Um2JmZgfptdMX6iZPRb53VH0Zme/mVcSW
         sQ4NeCkMhzKjw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4072DA006D;
        Tue, 28 Mar 2023 21:20:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8AEEA800D4;
        Tue, 28 Mar 2023 21:20:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="XaAxncKj";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d75Hp04kEprX7WqorURZE36nAzLhOgRCtP2X0DTeL7A38lJ5F9PwyCA0xwk04OVaAM6dF+iYw3AQy9SFIyIVvFGFiTMRIdaNvCaJKBjWnqtFJtB0yDOQZZSnciRmApmcInHXMkoVIaDH1ILKD3Y5H4aLj2y/jTtni4d/nFyVqZRAFS3eUnkUY/CdzAd6OkXmgX2Zw2k8PcdRBSsfbNFRyGzYMMa1x7KRN8y6hNkuGAXoVaWGyde2TLc0yPRgKp7kRxUw5tcqUSYDeI/vwaF+IfGpBzsFLAqpAks2q0+GbC/z0FoZa98Gef20Mj9JF5xWk+Eg8tFkOeAJRuaGyoj+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P+pRt+QgN8rjRApKXyr1rVmLrCyztysoEUbCdjFI/Q=;
 b=k3yF4ubbL11zvHRLDNO57e7eITTbda6ckM15g2IgyWSMYXi+wUYeMPtS/Mc/5MYlMUH8PsNdRFNr1JARoO4VpoRok+EKMKosQFxgWqU7Ci6sbYHqYRb2U2uVVGqr6cebeDB19gTHgayV1VgCC422xNpf1nNNhwQ1RnA382U77CxQsM6IODPpcukHyjxrNuVIKoCUs7QqSbmvkHA6M9uPqQKybgInW7ikYqbZ18KokPDsXn9O0yzoWuX2rVDzen1Lea5d3plJqZUUwjuMWBbkp0kit1bNzoTMrRW/hdyzU7DKFMWx6OPv5eHDb4UBjBkLoQE4rjwkCDDeIb8Z/4a79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P+pRt+QgN8rjRApKXyr1rVmLrCyztysoEUbCdjFI/Q=;
 b=XaAxncKj8klGwmQjEjXjuQYupelhrat8z9JCAxQ2MTwa+6yQUw7wwYn34hLZ9moZz6TmfWS8ilp1eYIoUR+vcbTBq+bCBd+F5fmiNmQC4SwXhJFAHV7tNGJEzrPEBrVwo2qf5F+FSs3eg/P86Q4ce5h1rXOuCnXwEQqnCKFjBCk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 21:20:50 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 21:20:50 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Topic: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Index: AQHZYY+ZaTJWoGmlmk+xC9kJuoh9G68QszUA
Date:   Tue, 28 Mar 2023 21:20:50 +0000
Message-ID: <20230328212048.rpm4ly265etahwm3@synopsys.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
In-Reply-To: <20230328160756.30520-2-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|LV2PR12MB5726:EE_
x-ms-office365-filtering-correlation-id: ed030317-8b54-4961-2395-08db2fd24e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdKQp1uV3nAtBkSOYQsAQtB/8upW4V3lZVexxyOeISIQvYMrcjkrNj+OBfVyITOcrLZHK/KCf1m9pibWGMZe2WtMe2oBUIQ5e7nrV6rR8MffbFClAVdRZSeuONvkMxGZ9kYp93RIUUGwG6n3RPVElcgGpDTBd85pxU6jR+ovGoh5Q1bVYjsBucwb2ALEaoOpb7SWUAmmObL2GmKB9B+Y+XFzklSdBrbtSkZkjqiBOlHHMjsX0VUpF9Oy6NLRlATfzcjuRQKkTnglhTH2bePPxbXtWwZERSchvUQqx5iUoFUzOpnrEUKuvZ/Nn6AqqlYmhexDVkWxeZzJv/y3pT5RsdGMKhpSWKIws+m7Hr2SWSJm/kwcaLqh2zjCRc+TZpqP2PlIV1XjJ5xy6xf2kN+77JCZqKSGIJH8HH7Id2b7t0sbpHz8veGFuHEBvBXRXaZ74RGOMyBiLLBogzgbtrlmHJNprDKsxyksAeLZCCxKBwi4Q8w+AR6Rc+mQhKd5/pqeqCAAqMh5bvw26VO8KjGwfsC5CLrrOYcf/zqZtz/1A2/2BSm3VyDZGc0NqrAqAVpADgoWtR/NHCv0hTzau3ZdWEkNB/bN6JoSpXJlW8tXbo3lLidTpY51Pk0wcvKGh3Jb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(6512007)(38070700005)(478600001)(36756003)(2906002)(2616005)(83380400001)(316002)(71200400001)(76116006)(7416002)(5660300002)(54906003)(6486002)(8936002)(66946007)(66446008)(186003)(8676002)(41300700001)(6916009)(38100700002)(122000001)(64756008)(4326008)(66476007)(6506007)(26005)(1076003)(66556008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmNMclFheFNwS2xTOUlYZGVZWlVqTGRHUktQeFJIVUJ2YlcwTGhaaUhtUkFH?=
 =?utf-8?B?VTNMZlZlY2dYVFNSWS9IcGNVWlhuYTVXL3BFWGxjcEVwOWE0WVhzNXJFdmkz?=
 =?utf-8?B?MzdyREFQVjJheHUyMXBOcEpqV01HYS9aOFB6eEQzK3hkVitib25qTVZiRVUr?=
 =?utf-8?B?WVp6bXRyTXBIaDBvVVQ4bDR4eExET0xndVJCY2xob2VRNkU0L3AxQnlzWURn?=
 =?utf-8?B?czMxbzNRc1MzenE1WmpiNVIvODdlcDhiYWZuODFRbVo1ekNxdzhnMThiYkx6?=
 =?utf-8?B?YTZuM2o2cUtpTHFPTmNPcGc3UW1RYndKaHJXTG8yaXltQUcvVmpFSy91M3FN?=
 =?utf-8?B?RHYzbFpBMUtZU0xuMm9VNmlSNUppaWZOV1lpdU5NVlQzcittN29oK2RTdFlJ?=
 =?utf-8?B?NFpjMDNhVFV5eHF6c2FzNy9zSmcwWE40bUgxcXZodkExOHhIN2FsUEpuSnpB?=
 =?utf-8?B?N3Y1azJhTDEzU0hiRE9DcXYxUmd5OGpXUFFLUEc4RURoRHNLWG1GVzI3blov?=
 =?utf-8?B?SlNDL2NzUVllenE4ajA0bmNCd09ETkRkbVl0T2U4TkdaUHRvU0dZc1VmczlZ?=
 =?utf-8?B?NjlQQlRpbWF0ZDdmbjExZTVVSEptQnNOUnRLb0lqV3p2Y082MklSVVdqYksy?=
 =?utf-8?B?ZnAxUWJWeHRha1BIU2FCWUR3MmwzTlM0Y2FRQ0UzbmR3WSt6TnExYnQwMmxW?=
 =?utf-8?B?aUhJbEhKQWpNUXc5NWhJVXFhUzdiZVpTai9hMnFKa2Evd3VRTi9ZSzNqdXZs?=
 =?utf-8?B?bjVBd21ZTkZrOXJoMkJ2S3lZK2FacjhvR3E3REdjd29hNjlIQ21GdVN2Vm9z?=
 =?utf-8?B?cmltcTRpRXBRYUNqZWxha2wvaERSTll5VFl4VlVqZUo0Wkp2azJ1bitDVmRh?=
 =?utf-8?B?bVdwL01IM3VFczVCMlNKZ09uNDliMHM3cFpXYW9BUkJBb09NTVBPRThZbFJQ?=
 =?utf-8?B?Zk5FUDQ3YTdkNnVGcUIrZHRaUDlpTVVjOEpzQVpQSzE5bzJ4MzFJL2g2cEI4?=
 =?utf-8?B?R0QvazF6YXZ6YmpFNGFab0J0ZWN1Q1UzSm83OTJxSU5GcmpDRko0bng3N1BK?=
 =?utf-8?B?WTUyRTNOREdIUEFVbTF5L0tjMjJSc1hVS0lLL1d1ek5NdHNWUUp4Ylp4M1lB?=
 =?utf-8?B?c1p3UlR6ZEsxVEVPa044dEYxMWxseTdndWdBMW9VTW9CN2svMDRrQ2ZJZmln?=
 =?utf-8?B?OXVTaHUyODZ6eDNhYVkvZnpCN1pkVEdpdG5VOUNBWk9WZ0syU0o1dUUzOU1F?=
 =?utf-8?B?enc5V0QxR1hVd2F4eVBUNldrUm1Bck1ndWZlV0JBTnF4S3M2c0dSTSt5ZnBh?=
 =?utf-8?B?V0RGaE8waklsUEp3YllaNkdCOXhSZHdhUmRSTFVlTmgyNW5nNll2ZWFpSFFG?=
 =?utf-8?B?cGp4Q0pxejhjbkdSOWwzRTRVcEFwV3laTHBrMDlxVEJmUGsycHpVWU9Wbzg2?=
 =?utf-8?B?Wm9IQWd5ZE5HVUFjMStCTzF6bkthMTRzKzhKaVp6dGlFZXNFWkhRR3FUb1hz?=
 =?utf-8?B?Znl1TmM3NWIyd3dBUjA5WWFHV2tReFEyVWpaRksydHpUNmFSa3JnM2c5TjVl?=
 =?utf-8?B?RFRnaUFwR0o5QXZDeFN6bFRyNlNvcnhEVWtYa0FmWFFRTDRqc3ZhN0c1VGFY?=
 =?utf-8?B?bmFRMjBJRnRsZXFrVjZNOEVreGNqT0x5NEFkL1NacnZKMGRZaUM0TTljZ0pE?=
 =?utf-8?B?Vk96dUdRUnkzWUorajkvV0pCajZFeFMyU2NvM0lXUTBXUGJUd21hVTNNY0tl?=
 =?utf-8?B?TzR4RDNxWnVmSnV3cCtBMHREMlZkbkluTmZSWW9nN25sY1NkZk1XVUFOWGtw?=
 =?utf-8?B?RDlNRjRQRzY5Z21QbXdXNHhlYXI0UjcrUmE5VGtaVmtQRHJ1MDRJVVN2ck1K?=
 =?utf-8?B?YlNEVXExdG1ieDVVei9MdGVNN1lWeE05Yy9Qb1JaNGR0MGsxaGVuZW9FcDJu?=
 =?utf-8?B?MTZFMTZrVGQ0QTdqL0lwQklVLzNZRDZodER0QnZldjQ3aHgvSFZlYkdJL2N6?=
 =?utf-8?B?dDBDelIxNXRmRU9zbnMrZkNuWDc4aVRBVkU4bFRIWFZ2YzFYVzhPNE90bVRq?=
 =?utf-8?B?Q1FnTzVXblptWlpBM2kwR1I0SkM0cExoMWhoSitpTlFTVjFUNTZBOXhzVCtn?=
 =?utf-8?Q?7GE1jPbcsPFhMDteR8fVQwA7T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10142D28FC2AFE49B032C14F2782356A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bk44amI3YkNlMjBOMURtRjNERXB3c04wdFNPY2hPcXMzem90V045bXB2SVZN?=
 =?utf-8?B?cittckFsUExQc1Vsd2tpRVdiWkMzSm03K1NnbzNKUVVtVHFmQW1wRDVocE9i?=
 =?utf-8?B?bTBwdW9JSkVZQUpObjFNRnNFSDFBa1RTL2JSN1JaN1NwcXQ0VTkwSm5wY1hC?=
 =?utf-8?B?TTBjdXF4YmdMUlk1YmtGNlJ1bTdCcnAvQTBTTC9NWHJFMXlpdWIzQWJVQ3FH?=
 =?utf-8?B?VzQwUjZZUUpiRVpCZW1VRTgwcWRML2FVU0JOYWNya3N0dkQ3N2VodDgyNVB5?=
 =?utf-8?B?WW82eUdpZ2JJa3RzTFllcFFKbC9MWmNDWU1uTE5XcVVQcXJHQlRIMS9tMHBF?=
 =?utf-8?B?ZWJlbUhNTzNKeTBkei8xemg5YzUrZVRTK1pKWlp3NThwZThKdFJQbGJlRHo1?=
 =?utf-8?B?c2VIZ24ydmVna2g0bnBnR2VWZWp5SXFHTHczcXgyOUJkN3k3RnRIdm9PMmNm?=
 =?utf-8?B?SW1lWU5naTgwTTRHaUlxZkJucVIzeUs3dldvelRjbUxiWmY0Q29SYi8rQlEr?=
 =?utf-8?B?aGNkSVZFeVl3RDZzNmIrUm1iKzhFMFBpcExRdjZvM2Q4N0drSldIUHdJOVNT?=
 =?utf-8?B?aVd2R3B5MVZTVGJQd1Rxc3g5Q3FNSlZuOTBaU2dXbDhXemFYdk9yRXZqOUhV?=
 =?utf-8?B?OU0yam1KYjA1SHJ3RkVJN2RlMjVPUlk4S241c0FNc2gvcEN6eTJWdVZ4RnRx?=
 =?utf-8?B?cFVHK1JFWWNtNDZGTTRwcTVveUJTR1d2OHphT2hhUFdqOWIrSnlZV0R3Y25J?=
 =?utf-8?B?VUQvYmxJWkJlV0Y3N25XTXB0VmhnempxTEFscjFFTkZoOEZXc0Z1TUorcjU4?=
 =?utf-8?B?azJDQ0VybDkyWUx0MHdPYXlIUndZTTVxdHRuNzE3U3hvc2pwODdSVW8rbnJR?=
 =?utf-8?B?VVNBbFMxYm9rR0lIdXU5K1FIOXJnVjZuNWxlS1FqVnZ6OWRBVzR4QUVpSlJI?=
 =?utf-8?B?eE8yMVVXM3F6ZWdueVVkYkVUSkYycEljWnI1N3AycER2NkY3cG8zc0RSTWZZ?=
 =?utf-8?B?SGNpc2ZQcjhHazdRMGFuTlh2NnFuTnhKNTlYc0o4a2ZRVmNqMkpjdjh0eks5?=
 =?utf-8?B?Nk00RnZsMFQ1OS95andRTXBBWk5TZWppc2VwQVRUeVNqTy85RlZIejJZbU9U?=
 =?utf-8?B?RC95Q0VueVNpQ2ppbzdSV1dDODFmMFgzdnJlZmtFQXFuZU5iTDV4Vjhjd2Rh?=
 =?utf-8?B?VGMrOE5uNUg3SGlWVE5ENXdRUHp0RUFxSzBwUFhVTGhDMjE2L3BKSEV2OC9h?=
 =?utf-8?B?ZnhQNVlBQjdZUjZEdDgvRlQvcS9CTzdTMjNpTW1KZVFGSHBTWDB0bnpwU1d1?=
 =?utf-8?B?NjgwVGhwSEsvNjNNY3lYbTlvTUVmZ1FXQ0ZpYTc0dTFKK0luTWtHcU1aVWR3?=
 =?utf-8?Q?B9pW+QVZB3CC/zgMrb0FLPkPZicvv4I0=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed030317-8b54-4961-2395-08db2fd24e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 21:20:50.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Fdox6z1wbEAhd1piB3DZgJuBYVLhzVhRENHncCDHutrSjLk+9aS65ZhjDWyRrbQB1OQF0+2H05T7rZGf9+g/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
X-Proofpoint-GUID: 1Uyv5IoB9x6nyPo2YMLAX0T_2gLa5RcJ
X-Proofpoint-ORIG-GUID: 1Uyv5IoB9x6nyPo2YMLAX0T_2gLa5RcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 malwarescore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280164
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFR1ZSwgTWFyIDI4LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiBJ
ZiB0aGUgY29yZSBzb2Z0IHJlc2V0IHRpbWVvdXQgaGFwcGVucywgYXZvaWQgc2V0dGluZyB1cCBl
dmVudA0KPiBidWZmZXJzIGFuZCBzdGFydGluZyBnYWRnZXQgYXMgdGhlIHdyaXRlcyB0byB0aGVz
ZSByZWdpc3RlcnMNCj4gbWF5IG5vdCByZWZsZWN0IHdoZW4gaW4gcmVzZXQgYW5kIHNldHRpbmcg
dGhlIHJ1biBzdG9wIGJpdA0KPiBjYW4gbGVhZCB0aGUgY29udHJvbGxlciB0byBhY2Nlc3Mgd3Jv
bmcgZXZlbnQgYnVmZmVyIGFkZHJlc3MNCj4gcmVzdWx0aW5nIGluIGEgY3Jhc2guDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1ICsrKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4gaW5kZXggM2M2M2ZhOTdhNjgwLi5mMDQ3MjgwMWQ5YTUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiBAQCAtMjYyMCwxMyArMjYyMCwxNiBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3B1bGx1
cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IGlzX29uKQ0KPiAgCQkgKiBkZXZpY2UtaW5pdGlh
dGVkIGRpc2Nvbm5lY3QgcmVxdWlyZXMgYSBjb3JlIHNvZnQgcmVzZXQNCj4gIAkJICogKERDVEwu
Q1NmdFJzdCkgYmVmb3JlIGVuYWJsaW5nIHRoZSBydW4vc3RvcCBiaXQuDQo+ICAJCSAqLw0KPiAt
CQlkd2MzX2NvcmVfc29mdF9yZXNldChkd2MpOw0KPiArCQlyZXQgPSBkd2MzX2NvcmVfc29mdF9y
ZXNldChkd2MpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZ290byBkb25lOw0KPiAgDQo+ICAJCWR3
YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0KPiAgCQlfX2R3YzNfZ2FkZ2V0X3N0YXJ0KGR3
Yyk7DQo+ICAJCXJldCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgdHJ1ZSwgZmFsc2UpOw0K
PiAgCX0NCj4gIA0KPiArZG9uZToNCj4gIAlwbV9ydW50aW1lX3B1dChkd2MtPmRldik7DQo+ICAN
Cj4gIAlyZXR1cm4gcmV0Ow0KPiAtLSANCj4gMi40MC4wDQo+IA0KDQpJIHRoaW5rIHRoZXJlJ3Mg
b25lIG1vcmUgcGxhY2UgdGhhdCBtYXkgbmVlZHMgdGhpcyBjaGVjay4gQ2FuIHlvdSBhbHNvDQph
ZGQgdGhpcyBjaGVjayBpbiBfX2R3YzNfc2V0X21vZGUoKT8NCg0KVGhhbmtzLA0KVGhpbmg=
