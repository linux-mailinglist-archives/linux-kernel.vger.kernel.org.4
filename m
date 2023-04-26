Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C776EEB63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjDZAXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbjDZAXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:23:21 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C05B208;
        Tue, 25 Apr 2023 17:23:19 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PNH8Hp003628;
        Tue, 25 Apr 2023 17:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=MbxZSxFknVDGEv7uGWWeAZAsGN/p4NX5PwMIURgcAlk=;
 b=TfwLbcLkB86Zek6sTOc0RnPENlFBb37zPbeQpKFcsb48EwD3MntYGlBJtSBGGgTtsoP2
 cAdvw6NGk0SBL8vyyVp2DQgCuNHj9tmdVs3Mw+bPZ5xjxVyHdyjZsteXxt2JsUox8iS3
 nmeQTAAAUjakTQukuAAKWCs1fV79r/gTOUHRGSr3KV8yRf+QgV0d0GtE4915fDR9GVGQ
 dOvDmKD0ETDfBez5C3bUpcIfpoFbtFTTMNT2RxrkeXm8zLdgLXZvRKYpi0L9UDe6bvuS
 tNzcyLBE0D2azeBvbE7WsDOEoV5zLLt03K8iIuBM8u488SNiHnyhh3WKNQm4zBINPk35 qQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q4egvfvsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 17:22:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682468571; bh=MbxZSxFknVDGEv7uGWWeAZAsGN/p4NX5PwMIURgcAlk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=S8XNmahB+0FC2nqLQTdjFLxX4bBCjiN4AJCb4i8+5lZzIxR2nODTDHpfYjkbeJAfT
         wy/89VuhcjYKHcR3NZPr6qHisK7nZ159koYfDQN6pVgx8rdoonapZBsh1+oX9K/XP1
         0rmP/Ggtxl3q2D1YWysxLLHbBFQtc/xV3zN9v5PRs7DxXkIr5EI0n4r+K2VEvw+KEV
         G24+CO+MLViqkeGqwH1dM507iD3zwfaqBfH7x223ozlb9Y5PUtJLBswLHUia5FzCA+
         PL+bfNSSKoQ3D6kk+r9rVMC3fyggQxi9d3T5AtWuCYnF6boOIL4fMd948cYbBRJt7a
         okcQZBS/IZWkA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 273AA40408;
        Wed, 26 Apr 2023 00:22:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2EB38A007B;
        Wed, 26 Apr 2023 00:22:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Ij86BoGz;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B778240523;
        Wed, 26 Apr 2023 00:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbxfJrPXJaYhE2kp4vBtcFN1H5OUbg31dGRXGjKXX15ecrFpEgEQjAadiQYlR4y4tr43aScVZaz22OX72vyrk0leguCmw2OG8ORiWu7j0ov/ugMvBM6ji8+RsEeZ1XMjCi+kRiSdJ5nnhuDbtJG/Zirm8RwUmZsfPnihSrFIRxEm6wkcyl1dcUMR8hikTNpTX/1yYKnBf8SsBzLAqZd3gSbv/V9oF3LYuoCTNjQHYRuAjZauqdglK5mzNayLVR9INj/xEDmyI0eK+0yebrsthJu4onC+Y3IvfhvOAHTdVq8+1C8NKU3CGO+QVL7gKovxF6FxU0ZZ9fhRl1lmc07OnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbxZSxFknVDGEv7uGWWeAZAsGN/p4NX5PwMIURgcAlk=;
 b=M+g+sBraLHaPdYmVH4PmN7q3YHtaSXk58SKhAGQfR91pd1ZRNNZ2UhzFNag5GkpYX+9nDLFu/dYP00hE9GJa4pi++4V4oH0UBFw96kAUD+WfB6m5drYESOhUdNnRvsE7aFPe6ehKu2KFzUYhm3cJWGwqHKwVvWJ8nz6IYuCe8Qh96BWa9/9uM8/ZhQdChKz9Dvux2MOJU67vciIomxYmU6gu8G1V7TVVl7MA78lgGdEhTIjLJ3juB+SJ2CYetfXkAoxK0pFRUUxdK/y6CpMWOjfel6bax2cpH391hdy49O5fP4FC6i/cUVIM/h1dQmTiMhsovzqN1Tx+yIZDjuo06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbxZSxFknVDGEv7uGWWeAZAsGN/p4NX5PwMIURgcAlk=;
 b=Ij86BoGz1wksOJwYYrpl6tg2prcnlrq8gowY17engzkyU2VXnzqn5rJ8Zjsn3VHYmfrqW6t/p8KQSxZRBl3+0p1iOEF/FV22GpPCa8eqNArAK2OdBVYDLL2XZJNoQWu66HdTtU6wy0n8IxZO1KyYLH6MvFYB7u+nUW1pJ0IXgYo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 00:22:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d%7]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 00:22:44 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
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
Thread-Index: AQHZYY+ZaTJWoGmlmk+xC9kJuoh9G68QszUAgAB5QYCAAUhdgIABGcUAgAa8LoCAAFDhAIABHkyAgABv8wCAAVUPAIAAGQyAgB7TP4CAAHv+AA==
Date:   Wed, 26 Apr 2023 00:22:44 +0000
Message-ID: <20230426000336.3yr2zydcniboe65k@synopsys.com>
References: <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
 <20230330001003.rwzo4n2hl6i22vh3@synopsys.com>
 <4f473d08-156a-622f-2ef2-ad11caa7ccda@quicinc.com>
 <20230403234937.sotn3pznu4winlkw@synopsys.com>
 <e769cc7c-8b87-c346-5cef-9d89f3ccb91e@quicinc.com>
 <20230404214347.mi6rmksr7pym74rp@synopsys.com>
 <f334b8b9-b8d8-240d-5ace-bed255f4609a@quicinc.com>
 <20230406004510.yxoxby2rwkalpqlh@synopsys.com>
 <e5e82a2f-dd89-bdfc-f521-c9d2543a139a@quicinc.com>
 <55cfaedc-bd33-610c-143e-0342a14a41b6@quicinc.com>
In-Reply-To: <55cfaedc-bd33-610c-143e-0342a14a41b6@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7490:EE_
x-ms-office365-filtering-correlation-id: bdf2a9c3-0a1b-44d1-3e8d-08db45ec5b27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsvP9hDAE/BTJl0Zgkl1+j6d+GrdjvEMTVaA7hsp6i91O7hCAgkDqN7s+c/BhsfJ2cNfdipgDMKaU2TDPjtzRylnprUCL6zktsV6AqpTOQGwO1Jy9+igodoWG0WJlB02jJ3J6hxw1LNYYoPMIW+v36NJx3XENCzU+cDpLXKIGA84lNZ5bm2JMP/1ptZWvcrDjqLmaapgrpB11ZMrEJYi9lw2BEai/O7H8yUMyvtoX+DnJhWqiLQLKHifte5QglJ06lRndiBTJMfqhoxsnwBMQo8abKy49NWcb3hloG1MgIAjC7qX4dTxVqBCzR0JGFyiFjWUczP4cTp2bSwb0QS1e87bmQBkMbzb0gjkYxDaz98MooZQAFqNsgQHjLsnPU7t0kbq5u9nOKmqLelivyVBed6j3auqX5JxLfdXJ+Aya6Oyn11Q+Q4334kgJOy8fXI8f7VJuqH2udRUa+YPJO/YfUad4Vw5KQZzLArrTB9NcSR/M63DJ+hb3l2APJYSv4eU1b25fAh92lyh9NZOYNGfp5XD8bPKg/U2Tn5ZZ58AlzUTaLYuO6DZ+aVLW61zIfaBIbWItOL0+73hQFf5WUpLaP2XNb+qruF1xuNiDBp0JxAPEWk/LOipAqIZn2T4AIvF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(7416002)(66556008)(86362001)(83380400001)(26005)(186003)(1076003)(6506007)(6512007)(53546011)(2616005)(36756003)(122000001)(38100700002)(38070700005)(6916009)(316002)(8936002)(5660300002)(8676002)(4326008)(41300700001)(6486002)(64756008)(71200400001)(66476007)(66946007)(76116006)(66446008)(478600001)(54906003)(2906002)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFNCUC9ieUh1Y3pvUGR4ek1MNXB4SmNHMWlnZGwySVEzUTVZSW9Db21LbW5N?=
 =?utf-8?B?anpKbHluQ29uSmwrQjBXTHhrOXNXK05vajBkd3RHZkJ1QTh2cGxyd2ljemhD?=
 =?utf-8?B?V2lpL1pZM3c2SEtLRGt1K2diVVErV081eUdMRFplLytXR2NPVzdrUUNKS25Q?=
 =?utf-8?B?SkY0OGhLUFpuSHNXYlhxaEhRdS9RNDBzMHhtYU9vZnVZdHVHeUlIMnliUlpm?=
 =?utf-8?B?MUxxbERlbmVWZ1JEYUNoSWVTVjdLK1kweUs5MXJuUnhUS0dKYUk1dWF2VjYy?=
 =?utf-8?B?MmdMVEJINmhNaXVMMWxwNFJvNVBILytuYmR1b1ZNMkJEMnpScVl6Ri9wd3Ur?=
 =?utf-8?B?bFpFREoxZjVHV2c2alBJVXZXeFFIV1J0czUvR3BTMW9BTzhGVTM0TUtsZHdt?=
 =?utf-8?B?M3BjbDBOL0I2VVBtVDNnMzVZSUppYWdLcjg2cmpjbmVaVUdwYnhYQjBOQ1NY?=
 =?utf-8?B?dFdTVnBhWnVWdW0rRjk0MHlkRTZIWi9kTUFWVm9LZnRYL2xMYzhZWGV2bVQ4?=
 =?utf-8?B?cmdlRVdTWnJGUlJodUZ0RGd2NXVnNUpnTzByQ1pnbGZ4NklHRWxXdGt3SUQy?=
 =?utf-8?B?OEZXbEYwVWx4S3dUdXhNK2RLYjhaMXFEYnVBRzJVVjVhRlV6dHFVQmNESk9H?=
 =?utf-8?B?WENYN3lJVDJ0RElzN29aNHg4dlV4Mzh6Mkc5eWgxSjRiblJwdFJFbExlSHc4?=
 =?utf-8?B?dTgxazI3QmhRUkxiK3F3ZU1wWmk3ajdER1NoTmZKYjhEMkQ5dkpNM3AweEgv?=
 =?utf-8?B?MklBNlplUm44QTBTOW5vaGNMU0RXWjUyV09na01HYWhtaHFlT01WcFV0ZG1y?=
 =?utf-8?B?cUo1c0ZDckE5YS9ZNGI4dmFuc3FaWks2MG8zQ1hDRGJOeXNNcFR6TlpHU2or?=
 =?utf-8?B?S0VKcFRzdzZBTEpaME54N29LQzNkMDlVNTRxenM5VmpJY2RycmFjcjVFRFVR?=
 =?utf-8?B?eXN5RUVhdmhtanhXUldVT2ltMW5MUUJUMlduYzk0cmV1OHRZc3J3cUo5RXlY?=
 =?utf-8?B?eTQ4QlJwOUs4SXdBRXBBekIwbHJ4V2JKMGhHMWFoMmRwVjlsV1VhcGUzTTVK?=
 =?utf-8?B?ZVM2YlJhdGFnb0dHbXN5bWhXTXB0eGVvUWpUOU42REZhYUVIYWZPTzBudjA1?=
 =?utf-8?B?UEQvNklwQndJTEYrdVh2Ym9ia2hiZnRpSnlxNS9EemlkYnorRkgwT3FKWVV3?=
 =?utf-8?B?VnVONHN0d09BZlVGb0pnWStySEljbFZEd0tCNExVOUdTZk1XeEhIcW83eG0x?=
 =?utf-8?B?RkxYaGx3OTV1eWF2ZkxFSjViTGF0L1NFdEthdGhjZXZaK09iczhQbkRWUFh5?=
 =?utf-8?B?Y0hoY0IrVjgzZU84L2l0YXdkNkhSS1VNQ0NhTlpQYjdXNFJDZW1DME04T0Rv?=
 =?utf-8?B?dldEVE5kTDMrMXdYQ25VbnFoS3FyU2E3QkcwM2pwODU1NFVMVHoyRkY1YnVs?=
 =?utf-8?B?eFRncHJoRGpNK1lTRnVsQXRsT09jOGFENXJmaHUrQ3NlVWlZNWFRSlFVa2Fv?=
 =?utf-8?B?RSs2bmh6N3gvZ25yWUxqbmxNdklWclNZU0NsWVZxczdzOTJxZ1NVeFZOZ2dm?=
 =?utf-8?B?SU1vZ3ZwaXRzOWQxYmxQYndMbDNvODdGYWREQzFFVTZLbG16eUFieitzY1RN?=
 =?utf-8?B?Q0pZNENiM2lNMklodmNoV2haUXF5STZhZWJHQ3NkOWVnU0VPRWdCL3hwbXd3?=
 =?utf-8?B?VjN6VEJEb0RRSW80NkZ5L2l3S25UdGxjdTJaVHZ0eEV4d05iRktCcm1qU0Vn?=
 =?utf-8?B?Z1hqNUNZU3NXUmVtd3c3cXp1dXkxM2xCaTk5WUREQUh1anhUc3V5V1FmRWx2?=
 =?utf-8?B?blJIOXpLR0dlcEplN3p1ck9aNFNxMURseUlwOGh0U2hHMS91Ymk2NGwwT2kv?=
 =?utf-8?B?ejdvQUJSemZXN0xPL1B2aERSWTl5UHFoaUU3djcyeDRYNk1uZmFmaTlERnp0?=
 =?utf-8?B?R3ZqOFgwaDlMK0Q1enE4QWNzbnlZcitUZ242aEFqU3JTSlJGU3dRZkpTd0Uv?=
 =?utf-8?B?WS84U3oyN0dzVEovd2pWTFJUMDMzZk1hcHVGbWtkZ2hiZnBKNkYwQ0xJUlcy?=
 =?utf-8?B?UlYvN0o1UjN0Vm9hVmtnYlpIaXgvKysxL0RNRnJVK0sreml0RWpuTGRDdkpJ?=
 =?utf-8?B?OVBlTU5JaDM2YXhXRE5XaHZMcWJDVUFQcVBMVUczRHpqMWJSYVhBNER5c3hu?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB25509D7A7C8844B8821F77CD179716@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDIzNTdoZU9tdWR2TitKU3daamUwQmJpZGxHcWpvQUl3WnR1Q0xQMVhGN3Nk?=
 =?utf-8?B?WWRBaUtPK0htSjRzUDMvOHlpcmE1c2xCM1JTUHNYWlA4OUJLWG81V1VKNnVL?=
 =?utf-8?B?YzcrbGNQakJCKy9nVkJnYURHMG4vYUZOZHc4N1d1azk4WVMvVWRzUHhIQmQw?=
 =?utf-8?B?OWd1SkNsU2NVNDY2QnQvcTFxV0pZTkltby9rcXZmY2FVT3U1bGJvb1lqTXNi?=
 =?utf-8?B?VnVIbU5raUZYSnV2MlRJR3FWWE1mT0VzY1p2VVNVd2dwZGNPK21SZ3pFNkJx?=
 =?utf-8?B?SXNrYlNVd1NFVFhGVXNnM0VvWEFZTVhrNkF0YitOQnhBb0F6eklxZjZGMkZJ?=
 =?utf-8?B?MGp2K09vMEs2bi9EbGNhQmZoMTIyOGxGVkRxQTBUa0RkdmNiVjYxYTZPemhK?=
 =?utf-8?B?Uk56czJ6Ti82bnQwUzJmblM2ZXhvRnl5UE9iNmtqam4wOFdBWWJQZHBsWFRv?=
 =?utf-8?B?ZGJwNWlobDRzSFBQNHlDM284RDN2Vlp4TDR4blVPdWFINjRtWWQ5dk1peGdj?=
 =?utf-8?B?MG12czFwMzB5bGNVYnZMR3luNzRRamJ0WmtrSENnVXdXQzY4UTYrUnRwTy9U?=
 =?utf-8?B?emZsdmN5L2FpdlJZMjMyRC9BQUhiS2JXZHAwYml2dmNWQUpzNDQ0QStZeGh5?=
 =?utf-8?B?elZvSU1ValdTNTUvQTZzclM4SHdjd0dtMkNzakFNRVpKeGR6TGphQnRYN2Jm?=
 =?utf-8?B?U0tEcnQ4b1h1WVFxeU9Jb0dQSHdid1RQL0ZZeGxZUTl1eW1oZlRWV1NrSFJY?=
 =?utf-8?B?ODNWNWVqb0FqWmNmNHV0ZjZGcU0yUFo2OWJ2SUlCL2hVSExOVWNUOU1rOG0v?=
 =?utf-8?B?MHpERG1UdjZ6Q0NJaTlwcEtiMGpFQTdSOFZDaGNmbjYzbGVTMTI2N3Zoa3Qx?=
 =?utf-8?B?MERWWHFLWldCS1lkcmtnbE5aSTZoaDNmNVdKdE40aU1WYlB1TjYwN0dRSnpW?=
 =?utf-8?B?NUZjZDRyZkVhTkE0dElJUGMwZjNIWjZGMGp1S3Voc1N2UC84RkFaQXBLYVlr?=
 =?utf-8?B?WGs5TUs0bEdOSFZpK2Fkc0liR3Awa21mcVJwV1p0MjZEWXlMRFV6TXRZcDUy?=
 =?utf-8?B?Uy96dE9sM0FVb0tOVU44WXBUWnU1UE1OUzJVTmZHSXhLdnhKWkJJcTgxdHZ3?=
 =?utf-8?B?SjUyODdmQmxyUzM4MmZMTzdtb2o1TmRDdnNVUWNOQS82bHRGNm1PKy9LM2NX?=
 =?utf-8?B?R1Fsc2VKaU1UZ2JhTHR5bjRHSlhoRHhYVHFGK3hoYzE0YnNVc2ZJODVMc3Uw?=
 =?utf-8?B?MlQ4UmFlck9GeUFKamIra0prZ2JXbUYzUXJYRGd6czVHdnhJUjJJKzVMcVlB?=
 =?utf-8?B?M1NyQkNVcTl1dnE2ckdtR1JTblBSaEhnK1NJcEVQY0kzU215Rk53c2RCWWxL?=
 =?utf-8?B?TmE5aGtmMytnaEE0L0pDemtlVmxwUHZ6ZytMd1ZYUjZFK1RvVU1pdGZBcllp?=
 =?utf-8?Q?BcwvGqHa?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf2a9c3-0a1b-44d1-3e8d-08db45ec5b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 00:22:44.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5B4eGlhslsJOXkhZeZi/XAPu/KJMzVyM2aaFH6Im67vmtk1ofVflBMmqRH/18RBn3nyFWKf8s1uEqef2ZGe3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
X-Proofpoint-GUID: 8DEnVLeW8eBE0_smOHAxznz10bJldEUf
X-Proofpoint-ORIG-GUID: 8DEnVLeW8eBE0_smOHAxznz10bJldEUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMjUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNC82LzIwMjMgNzo0NCBBTSwgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90ZToN
Cj4gPiANCj4gPiANCj4gPiBPbiA0LzYvMjAyMyA2OjE1IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6
DQo+ID4gPiBPbiBXZWQsIEFwciAwNSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90
ZToNCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiA0LzUvMjAyMyAzOjEzIEFNLCBUaGlu
aCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCBBcHIgMDQsIDIwMjMsIEtyaXNobmEg
S3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gT24gNC80LzIwMjMgNToxOSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiA+
ID4gPiBPbiBUaHUsIE1hciAzMCwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBPbiAz
LzMwLzIwMjMgNTo0MCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4g
T24gV2VkLCBNYXIgMjksIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+ID4g
PiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+
ID4gT24gMy8yOS8yMDIzIDI6NTAgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBIaSwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBPbiBUdWUsIE1hciAyOCwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IElmIHRoZSBjb3JlIHNvZnQgcmVzZXQgdGltZW91dCBoYXBwZW5z
LCBhdm9pZCBzZXR0aW5nIHVwIGV2ZW50DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBidWZmZXJz
IGFuZCBzdGFydGluZyBnYWRnZXQgYXMgdGhlIHdyaXRlcyB0byB0aGVzZSByZWdpc3RlcnMNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1heSBub3QgcmVmbGVjdCB3aGVuIGluIHJlc2V0IGFuZCBz
ZXR0aW5nIHRoZSBydW4gc3RvcCBiaXQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbiBsZWFk
IHRoZSBjb250cm9sbGVyIHRvIGFjY2VzcyB3cm9uZyBldmVudCBidWZmZXIgYWRkcmVzcw0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gcmVzdWx0aW5nIGluIGEgY3Jhc2guDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNo
bmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqAgZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDC
oMKgwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gaW5kZXggM2M2M2ZhOTdhNjgwLi5mMDQ3MjgwMWQ5YTUgMTAwNjQ0
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMjYyMCwxMyArMjYyMCwxNiBAQCBzdGF0aWMN
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGludCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0DQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24pDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IGRldmljZS1pbml0aWF0ZWQgZGlzY29ubmVjdA0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gcmVxdWlyZXMgYSBjb3JlIHNvZnQgcmVzZXQNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiAoRENUTC5DU2Z0UnN0KQ0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gYmVmb3JlIGVuYWJsaW5nIHRoZSBydW4vc3RvcA0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gYml0Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoMKg
wqDCoMKgIGR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBkb25lOw0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHdjM19ldmVudF9idWZm
ZXJzX3NldHVwKGR3Yyk7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBfX2R3YzNfZ2FkZ2V0X3N0YXJ0KGR3Yyk7DQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBkd2MzX2dhZGdldF9ydW5fc3Rv
cChkd2MsIHRydWUsIGZhbHNlKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoCB9DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArZG9uZToNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBwbV9ydW50aW1lX3B1dChkd2MtPmRldik7DQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tIA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMi40MC4w
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBJIHRoaW5rIHRoZXJlJ3Mgb25lIG1vcmUgcGxhY2UgdGhhdA0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IG1heSBuZWVkcyB0aGlzIGNoZWNrLiBDYW4geW91IGFsc28NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBhZGQgdGhpcyBjaGVjayBpbiBfX2R3YzNfc2V0X21vZGUoKT8N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IEhpIFRoaW5oLA0KPiA+
ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoCBTdXJlLiBX
aWxsIGRvIGl0Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBXaWxsIHRoZSBiZWxvdyBiZSBnb29kIGVu
b3VnaCA/IE9yIHdvdWxkDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGl0IGJlIGdvb2QgdG8gYWRkIGFu
IGVycm9yL3dhcm4gbG9nDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZXJlPg0KPiA+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSdzIGFscmVhZHkgYSB3YXJuaW5nIG1lc3Nh
Z2UgaW4NCj4gPiA+ID4gPiA+ID4gPiA+IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KCkgaWYgaXQgZmFp
bHMuDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+ID4gPiA+IGtyaXNrdXJhQGh1LWtyaXNrdXJhLWh5ZDovbG9jYWwvbW50L3dvcmtzcGFjZS9r
cmlzaG5hL3NrYWxlczIvc2thbGVzL2tlcm5lbCQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gZ2l0IGRp
ZmYgZHJpdmVycy91c2IvDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+ID4gPiA+
ID4gPiA+IGluZGV4IDQ3NmI2MzYxODUxMS4uOGQxZDIxM2QxZGNkIDEwMDY0NA0KPiA+ID4gPiA+
ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+ID4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+ID4gPiA+ID4gPiBA
QCAtMjEwLDcgKzIxMCw5IEBAIHN0YXRpYyB2b2lkDQo+ID4gPiA+ID4gPiA+ID4gPiA+IF9fZHdj
M19zZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKndvcmsp
DQo+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7DQo+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gZHdj
M19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiA+ID4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZHdjM19ldmVudF9idWZmZXJzX3NldHVwKGR3Yyk7DQo+ID4gPiA+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBJZiBzb2Z0
LXJlc2V0IGZhaWxlZCwgdGhlIGNvbnRyb2xsZXIgaXMgaW4gYQ0KPiA+ID4gPiA+ID4gPiA+ID4g
YmFkIHN0YXRlLiBXZSBzaG91bGQgbm90DQo+ID4gPiA+ID4gPiA+ID4gPiBwZXJmb3JtIGFueSBm
dXJ0aGVyIG9wZXJhdGlvbiB1bnRpbCB0aGUgbmV4dA0KPiA+ID4gPiA+ID4gPiA+ID4gaGFyZCBy
ZXNldC4gV2Ugc2hvdWxkIGZsYWcNCj4gPiA+ID4gPiA+ID4gPiA+IHRoZSBjb250cm9sbGVyIGFz
IGRlYWQuIEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSB0aGUgZXF1aXZhbGVudCBvZiB0aGUNCj4gPiA+
ID4gPiA+ID4gPiA+IGhvc3QncyBIQ0RfRkxBR19ERUFELiBJdCBtYXkgcmVxdWlyZSBzb21lDQo+
ID4gPiA+ID4gPiA+ID4gPiB3b3JrIGluIHRoZSBVREMgY29yZS4gUGVyaGFwcw0KPiA+ID4gPiA+
ID4gPiA+ID4gd2UgY2FuIGZsYWcgd2l0aGluIGR3YzMgZm9yIG5vdyBhbmQgcHJldmVudA0KPiA+
ID4gPiA+ID4gPiA+ID4gYW55IGZ1cnRoZXIgb3BlcmF0aW9uIGZvciBhDQo+ID4gPiA+ID4gPiA+
ID4gPiBzaW1wbGVyIGZpeC4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEhp
IFRoaW5oLA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoCBBcmUgeW91
IHJlZmVycmluZyB0aGF0IGlmIF9fZHdjM19zZXRfbW9kZQ0KPiA+ID4gPiA+ID4gPiA+IGZhaWxl
ZCB3aXRoIGNvcmUgc29mdCByZXNldA0KPiA+ID4gPiA+ID4gPiA+IHRpbWluZyBvdXQsIHRoZSBj
YWxsZXIgaS5lLiwgZHdjM19zZXRfbW9kZSB3aG8NCj4gPiA+ID4gPiA+ID4gPiBxdWV1ZXMgdGhl
IHdvcmsgbmVlZCB0byBrbm93DQo+ID4gPiA+ID4gPiA+ID4gdGhhdCB0aGUgb3BlcmF0aW9uIGFj
dHVhbGx5IGZhaWxlZC4gU28gd2UgY2FuDQo+ID4gPiA+ID4gPiA+ID4gYWRkIGEgZmxhZyB0byBp
bmRpY2F0ZSB0aGF0DQo+ID4gPiA+ID4gPiA+ID4gZ2FkZ2V0IGlzIGRlYWQgYW5kIHRoZSBjYWxs
ZXIgb2YgZHdjM19zZXRfbW9kZQ0KPiA+ID4gPiA+ID4gPiA+IGNhbiBjaGVjayB0aGUgZmxhZyB0
byBzZWUgaWYNCj4gPiA+ID4gPiA+ID4gPiB0aGUgb3BlcmF0aW9uIGlzIHN1Y2Nlc3NmdWwgb3Ig
bm90Lg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IE9yIGFtIEkgbWlzdW5kZXJz
dGFuZGluZyB5b3VyIGNvbW1lbnQgPw0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gTm90IGp1c3QgaW4gX19kd2MzX3NldF9tb2RlKCkuIEkgbWVhbiBhbnkg
dGltZSBkd2MzX2NvcmVfc29mdF9yZXNldA0KPiA+ID4gPiA+ID4gPiBmYWlscywgdGhlbiB3ZSBz
ZXQgdGhpcyBmbGFnLiBTbyB0aGF0IGl0IGNhbiBwcmV2ZW50IHRoZSB1c2VyIGNhbGxpbmcNCj4g
PiA+ID4gPiA+ID4gYW55IGdhZGdldCBvcHMgY2F1c2luZyBtb3JlIGNyYXNoZXMvaW52YWxpZCBi
ZWhhdmlvci4gVGhlDQo+ID4gPiA+ID4gPiA+IGR3Yy0+c29mdGNvbm5lY3QgaXMgYWxyZWFkeSB3
cm9uZyBvbiBwdWxsdXAoKSBvbiBmYWlsdXJlLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gU28gdGhhdCB3ZSBjYW4gaGF2ZSBhIGNoZWNrIGluIGRpZmZlcmVudCBnYWRnZXQgb3BzLiBG
b3IgcHVsbHVwKCk6DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBzdGF0aWMgaW50IGR3
YzNfZ2FkZ2V0X3B1bGx1cCgpIHsNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqBpZiAoZHdjLT51ZGNf
aXNfZGVhZCkgew0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRldiwgInJl
c2V0IG1lLiB4X3ggXG4iKTsNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0K
PiA+ID4gPiA+ID4gPiDCoMKgwqDCoH0NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IMKg
wqDCoMKgYWJjKCk7DQo+ID4gPiA+ID4gPiA+IH0NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+IFBlcmhhcHMgdGhlIGVmZm9ydCBpcyBwcm9iYWJseSB0aGUgc2FtZSBpZiB3ZQ0KPiA+ID4g
PiA+ID4gPiBlbmhhbmNlIHRoZSBVREMgY29yZSBmb3INCj4gPiA+ID4gPiA+ID4gdGhpcz8gSW4g
YW55IGNhc2UsIEknbSBmaW5lIGVpdGhlciB3YXkuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiBUaGFua3MsDQo+ID4gPiA+ID4gPiA+IFRoaW5oDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IEhpIFRoaW5oLA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiDCoMKgIFNvIHlvdSBkb24n
dCB3YW50IFVEQyB0byByZXRyeSBwdWxsdXAgaWYgaXQgZmFpbHMgdGhlDQo+ID4gPiA+ID4gPiBm
aXJzdCB0aW1lID8gQXMgcGVyDQo+ID4gPiA+ID4gPiBwYXRjaC0yIG9mIHRoaXMgc2VyaWVzLCBJ
IHdhcyB0cnlpbmcgdG8gcHJvcGFnYXRlIHRoZQ0KPiA+ID4gPiA+ID4gRUlUTUVET1VUIHRvIFVE
QyBzbw0KPiA+ID4gPiA+ID4gdGhhdCB0aGUgY2FsbGVyIChtb3N0IHByb2JhYmx5IGNvbmZpZ2Zz
KSBjYW4gdGFrZQ0KPiA+ID4gPiA+ID4gYXBwcm9wcmlhdGUgYWN0aW9uIGFzIHRvDQo+ID4gPiA+
ID4gPiB3aGV0aGVyIGl0IG11c3QgcmV0cnkgcHVsbHVwIG9yIG5vdC4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IE5vdyBJJ20gY29uZnVzZWQuIElmIHRoZSBzb2Z0LXJlc2V0
IHRpbWVzIG91dCwgdGhhdCBtZWFucyB0aGF0IHRoZQ0KPiA+ID4gPiA+IHNvZnQtcmVzZXQgKHNl
bGYtY2xlYXJpbmcpIGJpdCBpc24ndCBjbGVhcmVkLiBIb3cgY2FuIHdlIHJldHJ5IGlmIGl0J3MN
Cj4gPiA+ID4gPiBzdHVjayBpbiB0aGlzIHN0YXRlPyBNeSBpbXByZXNzaW9uIGlzIHRoYXQgc29m
dC1yZXNldCB3b3VsZA0KPiA+ID4gPiA+IG5vdCBjb21wbGV0ZQ0KPiA+ID4gPiA+IGF0IGFsbC4g
SXMgdGhhdCBub3QgdGhlIGNhc2UgZm9yIHlvdSwgb3IgaXQncyBzaW1wbHkgYmVjYXVzZSB3ZSBu
ZWVkIGENCj4gPiA+ID4gPiBsb25nZXIgc29mdC1yZXNldCB0aW1lb3V0Pw0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gPiBUaGluaA0KPiA+ID4gPiANCj4gPiA+ID4gSGkg
VGhpbmgsDQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgIFNvcnJ5IGZvciBub3QgYmVpbmcgY2xlYXIu
IFRoZSBpbnRlbnRpb24gb2YgcGF0Y2gtMSB3YXMgdG8NCj4gPiA+ID4gZW5zdXJlIHdlIGRvbid0
DQo+ID4gPiA+IHN0YXJ0IHRoZSBjb250cm9sbGVyIGlmIHJlc2V0IHRpbWVzIG91dCBhbmQgcGF0
Y2gtMiB3YXMgdG8NCj4gPiA+ID4gZW5zdXJlIHRoYXQgVURDDQo+ID4gPiA+IGlzIGluIHN5bmMg
d2l0aCBjb250cm9sbGVyIGJ5IHVuZGVyc3RhbmRpbmcgdGhhdCBnYWRnZXRfY29ubmVjdA0KPiA+
ID4gPiBoYXMgZmFpbGVkDQo+ID4gPiA+IGFuZCBuZWNlc3NhcnkgY2xlYW51cCBoYXMgdG8gYmUg
ZG9uZSBpbiBnYWRnZXRfYmluZF9kcml2ZXIuDQo+ID4gPiANCj4gPiA+IFRoYXQgc2hvdWxkIHN0
aWxsIGJlIHRoZXJlLg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBCdXQgdXN1YWxseSBzaW5j
ZSB0aGUgVURDX3N0b3JlIGlzIHRoZSBvbmUgdGhhdCBpcyBjYXVzaW5nIHB1bGx1cCB0byBiZQ0K
PiA+ID4gPiBjYWxsZWQsIHRoZSBlcnJvciB2YWx1ZSBpcyBwcm9wYWdhdGVkIGJhY2sgdG8gVURD
X3N0b3JlLiBJZiBpdCBzZWVzIGENCj4gPiA+ID4gZmFpbHVyZSwgaXQgZG9lcyBhIHJldHJ5IHRv
IHB1bGx1cC4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZGlkbid0IGNoZWNrwqAgd2hldGhlciBzdWJz
ZXF1ZW50IHJldHJpZXMgYnkgVURDIHRvIHB1bGx1cCBhcmUgaGVscGluZw0KPiA+ID4gPiBjbGVh
ciB0aGUgcmVzZXQgYml0IG9yIG5vdC4gQnV0IEkgdGhvdWdodCByZXRyeWluZyBwdWxsdXAgd29u
J3QNCj4gPiA+ID4gYmUgb2YgYW55DQo+ID4gPiA+IGhhcm0uDQo+ID4gPiANCj4gPiA+IEl0J3Mg
ZmluZSB0byByZXRyeS4gSSdtIHRoaW5raW5nIHRoYXQgdGhlIGNvbnRyb2xsZXIgaXMgaW4gYSBi
YWQgc3RhdGUNCj4gPiA+IGF0IHRoaXMgcG9pbnQgdGhhdCB3ZSBjYW4ndCByZWNvdmVyIChob3Bl
ZnVsbHkgdGhhdCdzIG5vdCB0aGUgY2FzZSkuDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEkg
bm93IGdldCB0aGF0IG15IHBhdGNoZXMgYXJlIGluY29tcGxldGUgdy5yLnQgaGFuZGxpbmcgdGhl
IHRpbWVvdXQuDQo+ID4gPiA+IA0KPiA+ID4gPiBJSVJDIG9uZSBvZiB0aGUgZm9sbG93aW5nIGlz
IHdoYXQgeW91IGFyZSBzdWdnZXN0aW5nIHdlIG5lZWQgdG8gZG86DQo+ID4gPiA+IA0KPiA+ID4g
PiBPcHRpb24tMToNCj4gPiA+ID4gU2V0IGEgZmxhZyB3aGVuIHJlc2V0IHRpbWVzIG91dCBhbmQg
Y2xlYXIgaXQgdXBvbiBjb3JlX2V4aXQgLw0KPiA+ID4gPiBjb3JlX2luaXQuIElmDQo+ID4gPiA+
IHRoZSBmbGFnIGlzIHNldCwgYmxvY2sgY2FsbHMgdG8gYWxsIHRoZSBnYWRnZXRfb3BzIGluIGR3
YzMuDQo+ID4gPiA+IEJhc2ljYWxseSBldmVuDQo+ID4gPiA+IGlmIHJldHJ5IGhhcHBlbnMgZnJv
bSBjb25maWdmcy9VREMsIHdlIGJhaWwgb3V0IGluIHB1bGx1cC91ZGNfc3RhcnQgZXZlbg0KPiA+
ID4gPiB3aXRob3V0IHRyeWluZyB0aGUgcmVxdWVzdGVkIGdhZGdldCBvcGVyYXRpb24uDQo+ID4g
PiA+IA0KPiA+ID4gPiBPcHRpb24tMjoNCj4gPiA+ID4gSWYgZ2FkZ2V0X2Nvbm5lY3QgZmFpbHMg
d2l0aCAtRVRJTUVET1VUIGluIFVEQywgaGFuZGxlIHRoZSBmYWlsdXJlIGFuZA0KPiA+ID4gPiBp
bXBsZW1lbnQgdGhlIHNhbWUgZmxhZyBpbiBVREMgYW5kIGRvbid0IGV2ZW4gY2FsbCBhbnkgZ2Fk
Z2V0X29wcy4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiBIaSBUaGluaCwNCj4gPiANCj4gPiBUaGFu
a3MgZm9yIHRoZSByZXZpZXcuDQo+ID4gDQo+ID4gPiBJJ20gdGhpbmtpbmcgb2Ygb3B0aW9uLTEu
IEZvciBvcHRpb24tMiwgd2UgY2FuJ3QgY29udHJvbCBpZiB0aGUNCj4gPiA+IGdhZGdldF9vcHMg
d2lsbCBiZSBjYWxsZWQuIFdlIG9ubHkgaGF2ZSBjb250cm9sIGhvdyB3ZSB3aWxsIHJlc3BvbmQg
aW4NCj4gPiA+IGNhc2UgdGhleSBnZXQgY2FsbGVkIGFnYWluLg0KPiA+ID4gDQo+ID4gPiBCdXQg
bm93IEknbSB0aGlua2luZyBhZ2FpbiwgSSB0aGluayBpdCBtYXkgYmUgb2sgd2l0aG91dCBhZGRp
bmcgdGhlDQo+ID4gPiBmbGFnLiBUaGUgVURDIGNvcmUgYW5kIGdhZGdldCBkcml2ZXIgd29uJ3Qg
ZG8gYW55dGhpbmcgZWxzZSBiZWZvcmUNCj4gPiA+IHB1bGx1cCgxKSBpcyBzdWNjZXNzZnVsLiBD
YWxsaW5nIG90aGVyIGdhZGdldF9vcHMgc2hvdWxkIGJlIGhhcm1sZXNzDQo+ID4gPiAoaWUuIGl0
IHdvbid0IGNyYXNoL2JyZWFrIHRoZSBzeXN0ZW0pPw0KPiA+ID4gDQo+ID4gSSBjYW4gZ2l2ZSB0
aGlzIGEgdHJ5IGluIGxvbmcgcnVuIHRlc3RpbmcgKEZvciA3LTE0IGRheXMpIGFuZCBzZWUgaWYN
Cj4gPiBhbnl0aGluZyBlbHNlIGlzIGJyZWFraW5nLg0KPiA+IA0KPiA+IE1vc3QgcHJvYmFibHkg
d2UgZG8gYSBjb21wb3NpdGlvbiBzd2l0Y2ggLyBQSVBPIGluIGJldHdlZW4gd2hpY2ggY2FuDQo+
ID4gY2FsbCB1c2JfZ2FkZ2V0X3VucmVnaXN0ZXJfZHJpdmVyIHdoaWNoIG1pZ2h0IGludm9rZSBh
IHB1bGx1cCgwKQ0KPiA+IGZvbGxvd2VkIGJ5IHVkY19zdG9wKCkgYW5kIGxpa2UgeW91IG1lbnRp
b25lZCBtdXN0IG5vdCBiZSBhIHByb2JsZW0uDQo+ID4gDQo+ID4gPiBTb3JyeSBmb3IgdGhlIG5v
aXNlLCBidXQgSSB0aGluayBpdCBtYXkgYmUgb2sgd2l0aG91dCBtYXJraW5nIHRoZQ0KPiA+ID4g
Y29udHJvbGxlciBkZWFkLiBJIHdvbmRlciBpZiB3ZSBjYW4gY29uZmlybSBteSBzdXNwaWN0aW9u
IG9uIHJldHJ5PyBJDQo+ID4gPiBiZWxpZXZlIHRoaXMgaXMgbm90IGVhc3kgdG8gcmVwcm9kdWNl
IG9uIHlvdXIgc2V0dXA/IElmIG5vdCwgSSB0aGluayB3ZQ0KPiA+ID4gY2FuIHRha2UgeW91ciBj
aGFuZ2UgYXMgaXMuDQo+IA0KPiBIaSBUaGluaCwNCj4gDQo+ICAgSSBnb3QgdGhpcyBwYXRjaCB0
ZXN0ZWQgb24gdHdvIGRpZmYgR2VuLTIgdGFyZ2V0cyBmb3IgYXJvdW5kIDEwIGRheXMgYW5kDQo+
IG5vIGlzc3VlcyB3ZXJlIHNlZW4uIChObyBTTU1VIGZhdWx0IHNlZW4gb24gYSAxMCBkYXkgcnVu
KS4gTGV0IG1lIGtub3cgb2YNCj4gYW55IG90aGVyIGNvbmNlcm5zIHRoYXQgbWlnaHQgY29tZSB1
cCB3aXRoIHRoaXMgcGF0Y2guIEVsc2UgSSBjYW4gcmViYXNlIGl0DQo+IHRvIGdldCBtZXJnZWQu
DQo+IA0KPiBSZWdhcmRzLA0KPiBLcmlzaG5hLA0KDQpUaGFua3MgZm9yIHRoZSB0ZXN0cy4gU28g
eW91IHdlcmUgYWJsZSB0byBvYnNlcnZlIHRoZSBmYWlsdXJlIGFuZCBhYmxlDQp0byByZWNvdmVy
IGZyb20gaXQgd2l0aG91dCBTTU1VIGZhdWx0IHJpZ2h0Pw0KDQpUaGFua3MsDQpUaGluaA==
