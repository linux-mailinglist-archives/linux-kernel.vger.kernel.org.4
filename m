Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7206F78C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjEDWEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:04:33 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F651154B;
        Thu,  4 May 2023 15:04:31 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344G0oK2016092;
        Thu, 4 May 2023 15:04:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=CzYay0A0FLjmcUdTjqWY0fF2qt2Xyy/33DD2v1/sDaw=;
 b=C+MtyF1bFf2EzpJQIFUkKlmZPDuucRdZZAhcfibFizmKBBL/Gq4R7bLL5O3JTaeW+Pn7
 6p+rp7dYpEojGuhVyXhEfb+rqyUvUZAVsaufWJ90h3Z/rH4B0CwUchXBMAHbf1Cp6Dwr
 KpsTUe81MFSoVG8L/77ZHpxEixxZU3imfjZYE082x8Hk51XIgepGYeDf1imV1JB8baDV
 Yu472ySanxvjrIvokCd6vsn7Tkdg94CMBruE1pL2uM4OVSN4yJn8kjAxapdhaf+SxT4q
 GwAh9wrv7Jlfzf61zjg3h+wPxd7cGqZTf8B82iZNoPGsikeH13eqlvKJpF6AxiHX1DQw tA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q92g9s2c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 15:04:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683237868; bh=CzYay0A0FLjmcUdTjqWY0fF2qt2Xyy/33DD2v1/sDaw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AVtnRefKUKn2/8tzIEquina91WFQe17f1+2awDuJNrezV8zRUwKEZsHFTcimU2UvZ
         F9j5bBsadTnB2BZoAguIOcCio4qdG9Vc0Xxw7HMOCwTwdpfE/E4N5EMDav+o4Kk552
         rylr2h1HuALUFxN5wYnq6bRYrJ11a/O6l1oWV/DjjDgQADslefZP2mV9n5SwdVxvqg
         zEd/siDFGhEcXOc6cmsIyBF3WSuUHnwsCaTl8oCDNQ59lM7i8ywJ3KujxwMHEemU19
         rAm7b58q9entMF3acJZhybbgHEkdyQJVc/x2itp8cIjH7018xZk40+o7htCOAQadxD
         H0KTjUQsHnNIg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7829640522;
        Thu,  4 May 2023 22:04:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1D936A00A2;
        Thu,  4 May 2023 22:04:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=MZUP4a62;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5EA2D4045F;
        Thu,  4 May 2023 22:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeFBnJRuQljDcuMIvGrgSMjxbZr5uiUq/NroU8mAaIFjIYOA+DZxY+BUlqV3ZEbAI71U8zEumVUNj1smLZzaXQnsesh/rfuSiF7QCAK9Z77Bfz/Y78j6lmnmSjyd9H8/Jbg02VjltiooGY8jPAcYNdHf5qHnMwKkoHrYxDNmD2m7b0m2hgIaDcy3lyz5piCPCvwUwLkoZuudGR8oLGL0CBdt5ADNpyRTGnsQa62lAYMHtX+vevOwhBLmD6kr0FT2mqRU5VLWsfxJ2b3tq+rNIIpwFymtleRYezaeuGS6U+tzv2jXAKkElAtuaKH6Ehy3Wcr+XjoJ7Xo2xUttjAsURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzYay0A0FLjmcUdTjqWY0fF2qt2Xyy/33DD2v1/sDaw=;
 b=k1/uC3IMiywGhq9MIFr2ITvmvmeDObdHrlQiGkU/LlugkOMMVnyK43RtD+2NI0eeQOgMUlt3pnQPbvRkLORYwwCKQkypekXkM2sIiDZuL6VTY3QXxKIpyXWQVFyif8WjxhQh4vlL7kqFAm5+D5f0ya3/DwmFy8A1a+ueIZNZTUOx8Rw20CBftpSG6tWwDMW9zp3T67cuClbu0AYTzm3f1IlTuS5lWan/mxc20UJnYxt5SB+G6VCJ5HFYM+Qg5k10EMYgjsXE51FwLWErAwUVcehitNl2yM1LGN3xwWKrJe85WwX8UpHjRKD/yQd5vIQ0aQjv79rytgH6H4CcTP/Ppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzYay0A0FLjmcUdTjqWY0fF2qt2Xyy/33DD2v1/sDaw=;
 b=MZUP4a62jNk2timhRQJ3rw4h6g5NfQGXcSBbHMtCXl08MqvLa8YTZOn4HKOJbmi2NMi6PSeEHF5nkkAh1WJeZ4JWzoWsp8TQU6aF4N9+qkRn3if74TIB2KEQ09lywF8cIvsP1Q4znwX6iFpSYEx30O+Ep2rBmDTc/kD4yFY59JA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 22:04:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 22:04:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roy Luo <royluo@google.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "badhri@google.com" <badhri@google.com>
Subject: Re: [PATCH v2] usb: dwc3: Add error logs for unknown endpoint events
Thread-Topic: [PATCH v2] usb: dwc3: Add error logs for unknown endpoint events
Thread-Index: AQHZfhuaMW1wRvDyS0iSReSzgqJcna9KrIGA
Date:   Thu, 4 May 2023 22:04:23 +0000
Message-ID: <20230504220413.puj4kbn5cqxbfhvp@synopsys.com>
References: <20230504000129.728316-1-royluo@google.com>
In-Reply-To: <20230504000129.728316-1-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB6661:EE_
x-ms-office365-filtering-correlation-id: 130a6157-75e1-4172-d033-08db4ceb84de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zzWfhX8oePlqNdF4cMNgH9dd5hVyGXPnj0ZxECQKFPdRla31+mKxdaamrtZSJ32i5pBiVfxC5kBJead67a8au9NBwplWYtdvcnPQbMIakVy4+wAtE6++3wo1jN/2n22Z+/rHwOwGteiI5TmmdK7MA/18DCyBX1YU4lac7tAYGcKeqcbm8ID99YtxohGzUiQzJ6gkCgzCVxzb3U4Mi5aM84Upl9bSlvkYQs4L9OlcZmbbWriS3Npyp4AmLdB9CGJEV+nfVkClP8PBZ+srHYZaVpwwMrkOQyjLpIp2jAalsv3frE9U/Rc4mlqfW3SqHICwVWQeUJZdALUxgZLEBlOsUQuSuFcWthxVhKhdEZFGIJ495rZO/YAZwZ8QQ1twM0/r+KZmPnWbDC2ZtFYDtHbabiS6uQFp4CpI2N4qWpIOFN9RjT5yew2HXeU5jv/sKjqi7qCjk7WpwVHGgRPgZjBy6DSxJjH4CON0+RuVaaQ0SLCnV6Sos3MpxtbiHekZilZTKOESUTBFlMbGq4F1sPf0EC8cYCuV5L/Yw1LJKhI5HzpYceDvTSZfQpGxC52O9GsJu18HuiANqEP9NlsIMWVwQ+ieYHmE1CQ43661/8+lgf62OTHxK+7kpizkPJ09iA7q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(86362001)(36756003)(71200400001)(66556008)(316002)(54906003)(66476007)(76116006)(66446008)(64756008)(478600001)(6486002)(66946007)(6916009)(4326008)(41300700001)(2906002)(5660300002)(8936002)(8676002)(38070700005)(38100700002)(186003)(122000001)(6512007)(1076003)(6506007)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVA0QlZwRWF5UU45Zzk4cUhYUENzS0h4NjNvT1E4MnFDY0dyWnZIOURyZzdT?=
 =?utf-8?B?ZGRDR1I3SUFPd1pmNDJwRWlQbVhUb3JGTWRyTUdpcll0RmhYbHNwWHh4cXJh?=
 =?utf-8?B?NmRvaDlXMXVZSC9zOURheFdrc1pLMDYrWktvRHIxU2l4WklhNitWN083T1M4?=
 =?utf-8?B?Q0xTeW94S3hjZ3FUcVIwTncrbExKMlNtcjlRaWRxSW1GUldSOThOQ0xyeE56?=
 =?utf-8?B?VkR0NkdpSEFHQjhlcFNoM096SmY0UHp3cHYwNTBSTWpuODljU2ZWYW5iK2k4?=
 =?utf-8?B?YWY5bmZibm1aTm93YW5QOXF2cEFlZ1FDV1hTVUlBU3ViREZHTkdqVXdBRDQ3?=
 =?utf-8?B?QmcvQlZhWVJXbDlNNXhuTDJ4SWNzV2pCZEpYczJKKzZSR0VCVGx1TVNVSzE2?=
 =?utf-8?B?TnhxUXRQMjZRejNURE1WWXQ2UkpHRTlMcXlFOVVHT2NPWmlYZXFoemhkS3pO?=
 =?utf-8?B?blFrY2ZaUDY0Y0dKUlZiTXdRQ3Fyblk2VWhCRUIvdTMzbHYvNlkwVGhhSDBP?=
 =?utf-8?B?WkdxLzFsRVFRU0lNbGVncHloNHV6NklQY2pkL25CZmFDaWwva0dBQXVYRExP?=
 =?utf-8?B?NmxhTjFlWEFVYVNxSWVuQ2JiY0tTT0JJTGNmVVlJNy95c3ZsVEx4VnExS3Za?=
 =?utf-8?B?Q0E2YThBUFRjRDhaSmtIbWhpeU51ekNnOVVBdE9wendEelpUNEZlaDFUVUFn?=
 =?utf-8?B?RzR0dU5kbkw0amNYSmtPTUNFYnNHeU9JOTRaTEQ2RWYrN3Q1a0FVTlFtY041?=
 =?utf-8?B?OXZTWU1USWMzR3p1NzNmVWdTNzdxcWRFZ2ZsQ1l3ci9TODZ0RWhoT0k5NGk3?=
 =?utf-8?B?bndqeWhVTXNKemRTQlRFSWQwR1hBRXU3MHZpTTFaN0lLdUdaTFdNK2pmdldu?=
 =?utf-8?B?d0VFY1ZjVnJnY1plRWJWZVB3dU9EblJuWjRKdjVWMThpa2FhTkt2dFVIaTRk?=
 =?utf-8?B?dWVBNmdmdEFib1RZbW91N011NXphVi92TFAxcFRhcGRpZi8zS0VlT3dTMFE1?=
 =?utf-8?B?SE5ZQW91T1ZpZ0NpSmpvQi81b29NMkIvU09GT2Rzc1JsV2hFdVg1Skk2TVAy?=
 =?utf-8?B?MWFGMmdYUk5YNS92cWF0NzBPNGx5WEp3QWp6MUtucGRGRzlYTWJWRFQyV0RJ?=
 =?utf-8?B?OTRPczdrZ3JDajVGSzdxNlMrc29HbDg0czVtMDEzUlZtMk4xSXhXeC95SGg3?=
 =?utf-8?B?a2FwTGNJK2pGUTM5cGY4SjhFMVUyU3JpV0lCYmVNSjY3QmRzVldyTmxva0pz?=
 =?utf-8?B?RWRzZzhLSS9ZN3p3WWRRZnh1aXhtZFF3NVhIZEsyL3M2M2JQTVJ5NUJhK2w0?=
 =?utf-8?B?TmhiR2ZGYnhQTUphbmY0WldYQ0ZGWG9kd2VmYTVBQ1R4TG1OVGRJc1lQdWZ1?=
 =?utf-8?B?MFNUbzFRV3NQK25EdjEyb2I2aWxGRCt4K0swUDVsWkRIUG1JM2d0RHN4ZGt5?=
 =?utf-8?B?YTBSTGIwaE90VXErZ3N0RFkwQ0RCRjkzUmtsME1NTXdSZEcweFVYUU51WlpM?=
 =?utf-8?B?aUlwUTZHQXVhd0tYUWdJdkpFWElJSGlVTFpxdHVEYms3Lyt0Sll4VkNPUnkv?=
 =?utf-8?B?WDV3V2ZlUUZMZjN4Zi9UZzZ2dHhDbGNZYUJ5ZGtMQld0Unp4S1gxMHpBMHBh?=
 =?utf-8?B?VHE3SmU2M2R1Z2lxVW1jelp2MHozNEpOR3ZyNGhJa2VBSHBBZFJ0NktIdWJJ?=
 =?utf-8?B?YzRYUjVkR0J5MnJnN2I2cWVNR0RPUW4vemw2eDFCTmlZL0ZNdXo3SnJ3dThX?=
 =?utf-8?B?V1o0TXdLK09vMDkxRm1ycW5qa3VvSmJzWXB6TEdmMktIYk81eUdkQTVaaGNS?=
 =?utf-8?B?b080aU5kTURkODE4dmQzVkd4ZFlLRGRwYU1QRzdYUDYwSmRwakQzM0dvYVlZ?=
 =?utf-8?B?Tmxnd3JDQ2dkTmlXVUJMWHREUXhQMWNrTmVxc1VXTU93aEx6bFFHMG5wbU10?=
 =?utf-8?B?TGJTVXlnaDFoYjRmcW9RRVFBT1lWcE1aOVNoYnVacmdrY0lpcUFOaHNIUkVW?=
 =?utf-8?B?RmVtTUlRWHRRS2RidmJFVDVmSkgzS0taUlByM1FyUCtBR04rdkpLM0JTcUxq?=
 =?utf-8?B?VzUxQitmT3FFc0VSdFVqQlB6blFoWFpSeDF1SHhJOS9Sbi8wWVpWYVd0bk5O?=
 =?utf-8?Q?5iSTHg10W7lHTsXn3OO0YEJAy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1269EC27D98A344A3DABE8837340511@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Oys7yLyf7VVpUDtuGIrVHiflQrhGsBrQgL3z4eqc5uRYPS4P9Xzflm4pVH8IZ4NFWeM+oZlGHfLqj/V+2Z7V2zD+9OfDCawMjxpem5JSUTLf/R21Vw525kOBxEMjBcKcCXjU99c59TtmBzb5roludgVEg5ZXbtUZWpv07l7oms2r43kAysYKXPQHh/w93TQ0GrLj3n/sxCGnxCD2oU49PSE9l1tUa7NC+hkBkTaNsFX8rcbIGt7odjOQLjlufXWJBxWfCT3jIBWPlrwQBvSRcGVnUoiQNWINx6k7O7c6fqdbd3dvEZ2cBcEtKCRsp89rLD/0kDxSZHoC1+hbDzerQAFaLUvb/LLOli1U/qqmKtSHCrqrlA9VTOnnrOf1EFze1XpnKat+4M4ktyIUJ2PnRc4Wal0mnp8QaJ2v8iKJNVfh1eomddHxDIJXQ9RtPRXpeAOOziWq2oyePLgA16+QWD1M36ZtQKGkJNyHBg9galFBx3zQBimofUL009XXxnn+IqMA3b9N/GusYmnsSxohdn3qS6+AnfHh3Ny0fTd5GnP3kxgAIgeto2wzLi4YPcKXuLDbYrTaRbgk7g+EiA2yppOKkozhZEl21Bb6+Xlykd5hhJEMDkDoz7dT8av0azrfWAlo8v1c955jj2PCm77zmbFYcK8HzRPAVCFirgYCsZumXWu1P53aRxw7TNElKWI/DixD/Q0pXf5jxkaPxLB5NT5gipAXmJhf2nBs1vbMLt/JbJ5yIjlai+h5N8jZatSEABWR1b8ehrYNNRk+9ceOLylGejgSJyAC0PQM9ie5MVOlzxhaOU39S8SwEzLYs7FeQ2v7R6s9pLSaYikMENrFdbldUFL2oIeDg64fuEyEIW+c3ZvWV3/IRd2Z13jslryu
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130a6157-75e1-4172-d033-08db4ceb84de
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 22:04:23.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7FtBKWZKp3Z+NWH0hm27BLbpsCMfdzpbUN8pdQ1aHY1oot58ohWrgoF7HgPs92OAm6JQauFwOCxTARgR4B7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
X-Proofpoint-GUID: ZM8BP6I6BU9hJmhoRuW7RBTGgzF88bky
X-Proofpoint-ORIG-GUID: ZM8BP6I6BU9hJmhoRuW7RBTGgzF88bky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_13,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=817 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMDQsIDIwMjMsIFJveSBMdW8gd3JvdGU6DQo+IEluIGNhc2VzIHdoZXJlIHRo
ZSBjb250cm9sbGVyIHNvbWVob3cgZmFpbHMgdG8gd3JpdGUgdG8gZXZlbnQgYnVmZmVyDQo+IG1l
bW9yeSAoZS5nLiBkdWUgdG8gaW5jb3JyZWN0IE1NVSBjb25maWcpLCB0aGUgZHJpdmVyIHdvdWxk
IHJlY2VpdmUNCj4gYWxsLXplcm8gZHdjMyBldmVudHMuIEhvd2V2ZXIsIHRoZSBhYm5vcm1hbCBl
dmVudCBpcyBzaWxlbnRseSBkcm9wcGVkDQo+IGFzIGEgcmVndWxhciBlcDBvdXQgZXZlbnQuDQo+
IEFkZCBlcnJvciBsb2dzIHdoZW4gYW4gdW5rbm93biBlbmRwb2ludCBldmVudCBpcyByZWNlaXZl
ZCB0byBoaWdobGlnaHQNCj4gdGhlIGFub21hbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb3kg
THVvIDxyb3lsdW9AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2VwMC5j
ICAgIHwgMyArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAzICsrKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2VwMC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiBpbmRleCA5NTNiNzUy
YTUwNTIuLmI5NDI0MzIzNzI5MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9lcDAu
Yw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IEBAIC0xMjA3LDUgKzEyMDcsOCBA
QCB2b2lkIGR3YzNfZXAwX2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCQkJZGVwLT5m
bGFncyAmPSB+RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEOw0KPiAgCQl9DQo+ICAJCWJyZWFrOw0K
PiArCWRlZmF1bHQ6DQo+ICsJCWRldl9lcnIoZHdjLT5kZXYsICJ1bmtub3duIGVuZHBvaW50IGV2
ZW50ICVkXG4iLCBldmVudC0+ZW5kcG9pbnRfZXZlbnQpOw0KPiArCQlicmVhazsNCj4gIAl9DQo+
ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBjMGNhNGQxMmY5NWQuLjcxNjNkNWQwZWVhMCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+IEBAIC0zODAzLDYgKzM4MDMsOSBAQCBzdGF0aWMgdm9pZCBkd2Mz
X2VuZHBvaW50X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCQlicmVhazsNCj4gIAlj
YXNlIERXQzNfREVQRVZUX1JYVFhGSUZPRVZUOg0KPiAgCQlicmVhazsNCj4gKwlkZWZhdWx0Og0K
PiArCQlkZXZfZXJyKGR3Yy0+ZGV2LCAidW5rbm93biBlbmRwb2ludCBldmVudCAlZFxuIiwgZXZl
bnQtPmVuZHBvaW50X2V2ZW50KTsNCj4gKwkJYnJlYWs7DQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IA0K
PiBiYXNlLWNvbW1pdDogYzhjNjU1YzM0ZTMzNTQ0YWVjOWQ2NGI2NjA4NzJhYjMzYzI5YjVmMQ0K
PiAtLSANCj4gMi40MC4xLjQ5NS5nYzgxNmUwOWI1M2QtZ29vZw0KPiANCg0KQWNrZWQtYnk6IFRo
aW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
