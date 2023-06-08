Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E737286BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjFHR6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbjFHR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:58:13 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBEC30DE;
        Thu,  8 Jun 2023 10:57:58 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358Hl21B019119;
        Thu, 8 Jun 2023 10:57:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=xiucX1U7rGhdFbLe1Sdrfq3Oe3wHu/oWJ6txi9s7aRg=;
 b=VLgjAhIIlCbm6izi40rhP/qRD14VUUrJlbwF731S8ZWn1lo/DeeX+UVRNIGG1uhC4/qd
 69t2ZLrTBdWkuBFozXYuuldtb6Nm0QfTBStB77wmo2cGDN08Ct0XVUzAkBmO1VP3tcZy
 qM9ZxdKvP7vANPiaLrVZ0NxSVTwr+si92OUZAkmaSl/jtaEl+XX+F1vHMzxGNp6UCb3q
 MCRoG4oDKqbeuOAOVDcyGTyPr6CN7Q3lnQ8uRz1TEqX7SlTow0zXTCFjPDs4qERx1rcR
 5dvmuLKL7TfO3V3kZAnCSnYFt34THrN1kr0eNB1hB7qE5RDM/9H79Ie8+IRNoMf0zOss Fg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3r2a6xk9cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 10:57:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1686247058; bh=xiucX1U7rGhdFbLe1Sdrfq3Oe3wHu/oWJ6txi9s7aRg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=I+VaT0ngRoJn23JDmN535LFMDp7CI1Ykckz9luoW52mBxXi20nOmQdhidSX7set4d
         FEvTGqiiBsiiq54oFmoZytmDZ8KAQc0RAM5FBVEkReyShLUXUz9RTeWU/ezGn7pSgg
         63wtJmGyxvLbduE9UuTC2nd07RkvTltYyvVHltE8x9xvjbDepKESGUNH7QUSvJQqeA
         l2gZs5JNKKmhjJG0YpJTI6RS2qZ1TcQhYHneH212u39ZsEBL6W0/gXtMvs+YhZHPAu
         LcUQa7OP0qWKnzEjx7dv4rImkvPY7I2EncJnZ0mpIruPCr65ID+ugSFAq+lkH5epbz
         k5kx1/n6+y64g==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B516240362;
        Thu,  8 Jun 2023 17:57:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 21C30A0062;
        Thu,  8 Jun 2023 17:57:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kr7BM9mD;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2D39A4012E;
        Thu,  8 Jun 2023 17:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu4NLqnD3Vohe9KGFckHE7tt9GJPPO8VoXQr5kmVTXJklTDKQqLbnv014q7KS02zcVCUbdfsmoARC16Qp2rewo/3Qv4qjsPto7S38n+AIDOWtjaG90BUaIxVKBoaYA6g+bmw8KIaZ4Euo1qhXRhVympzz7CwWqu0NdtCMoMvEMlS17WVi4nKl6zpbI2zOMVPm20nGdBfrUMmARHhj2E/ARmapvmk11n8a9ClWtSceQFJSD3wQKUuQXb2ULGbebyUSCxce0YBJuwafpZL088jJr78KNJlT7gXjMukqKriO+u180VRcB2Xg++a0wdlpFXb+upnEuxqh8TTiNC3x0zOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiucX1U7rGhdFbLe1Sdrfq3Oe3wHu/oWJ6txi9s7aRg=;
 b=dgy4aBB9gFTWOlvjHrNt4BslrYuKk5W4wdh6bXP7qG4PpiAgZ3aoppCK0dDSBOGe6KEiHSbZOPZqMPoKI2Ul4WKcOa/KBH1rfN9dFEBSzASl3xkamn0NiRsyNO9r6pkzBph2MTNtgWLApwW72/8zWW9YC7UrW1Ek4Qa+MUJ7WaySIMPMhvAErvk7jzPnF3TASl5EZ6gqgA9NzJMaDnQzX90r0ezx0mGCnhMBYMolF38WqGiQilAWfv9aYGDwt++cH2iTeJmJH8MDn/5P8F27wLFNYZz70KmRFx4CBgAyWAbOfsPW/t0QK42QVBB9gDhPClCFjstuFa7Z0eKu08S+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiucX1U7rGhdFbLe1Sdrfq3Oe3wHu/oWJ6txi9s7aRg=;
 b=kr7BM9mD9sYluGDiiVi+GncqbUEvWP5daqvraTlH3IRFZKfGn8iu7BWpIGv88MVPxebdcib0kw5KxhpyRjsDZQe8XzrUbR5kJckPHMYQNDFZDPJzqPJnKcObHv01owPTjSNcOrW43VvcDjwM2TMO6vMc57gqwqznHE52yGI2jYc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 17:57:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 17:57:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Thread-Topic: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Thread-Index: AQHZhif6/qSXXM0dd0yowK/+LbRnLK9b7I4AgABAvwCAAoIhAIAEyu8AgBviTICAAInNAIAA6E6AgABfQACAACrxgA==
Date:   Thu, 8 Jun 2023 17:57:23 +0000
Message-ID: <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
 <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
In-Reply-To: <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB7033:EE_
x-ms-office365-filtering-correlation-id: 248d611d-a2dc-43c4-6a64-08db6849d00d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8FKgmA3Fw0jLvuuUH7uNSBKidWtCtroM4gAwcmNtsvgccn7Zmw86yY6HOlRIwUoDwojFEpFOvBRZePBxibYdkoCjTF9E8F+MzKmKI82VKIQEyYgWHb2VcusanmSmIlO4cqi1V+qjgmLycozo7uv4uunGKR+gZjnnGiF0CVIby0vDF/JitfLCxnzcgJzU7dwq9r5RC6tQy+sB1B4NQK7Zko/69DbkoyXrblS2Mnirlyz4RAEdvsoLELXkOl3d8E896KVhCp9I7MrxqTICEYE3/KfU978FRqC7oh7pjn0dWyY+1H56nRHHDL0UJiKa1hdZXLbS7A4h5CfWk1txuxt3R6IayZs+82HNdDxQT6L74NCkBB8HRoP0HhV30qdf/6yiTyzNez9RTeNEKOrIzotibdskCHKgFzQul0wzdmCOgClx/k0J1MWue7jdI+E74A59Vuk6WT07lqwXwsev893UPTBGHU330Cl3qyMD1XXm9O00XJpyPYR/4CF0sTEumzv/i4kj2Gy3P3hwIQ63EOlNPciAjncunQTfQFXuaSrKTdIg/113qu1xQqz4biDUDBXDbWInNYqhgGEiGTMXHQbxKFkXdB7tNWoAofO7qvnUjXdUisHrCZ8UFwo2KWQhdiFq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(66446008)(6486002)(2906002)(71200400001)(36756003)(66556008)(4326008)(66946007)(6916009)(6512007)(6506007)(53546011)(41300700001)(76116006)(66476007)(478600001)(64756008)(1076003)(26005)(186003)(7416002)(316002)(2616005)(5660300002)(38070700005)(86362001)(38100700002)(122000001)(83380400001)(8676002)(54906003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNMTk8vSm96aWN2Uy9NY0M0U1k3bTlMdlFSUVZMZzlld3JsSk9QYk5zN0w3?=
 =?utf-8?B?ejJuUE9Ra0dTcVNVZE9xS242ZGk2NkpibFRkaTQ1TGtOZTZtR0tmcTF5aVJl?=
 =?utf-8?B?WTB4TW96aUc5TjNhSnRhS0UrWGNnTVZrWkF2S0x1aGVYS080MTl3cE05MUF1?=
 =?utf-8?B?dHlxVlN1VzVTVm9Ub2g1ek8zcW1ET1NldjRqMnhFNWFaU0JIVmhkdUg4M1ZN?=
 =?utf-8?B?Wm0yM3pCb3A3clloOEkzZWg1YVNJbWZVckNsUmNoYTZmM0dYaUNoOG5iRlBu?=
 =?utf-8?B?aEhhM1NLN0hYbzhtZEhteS9ib2dVeEo3ZmM1OTBZdmpWTEhvTjFVNk1KZWlV?=
 =?utf-8?B?YVFLVk1SVTB3NXltVTZYNDBOd3ljSnBSb3NwUkxYQkR0c3F6cGhhTlRmYzRI?=
 =?utf-8?B?d1d1MEFaWFNqRmVwRnQ4dFMyelBmN2hOdkV5L0d6VnlEeWJUZXpkd0Joa3ZO?=
 =?utf-8?B?enI4WjdtWHcyY3BhbjdtRWFPcHVIcHVPRlBFb1gzcG5icXdKbHVTZmVwVGR5?=
 =?utf-8?B?NjNvcCtXYzJzSitHM01jY1JOOXVuQmNzTnRkZVRKT3Z3SjczUlEraVpyQlZO?=
 =?utf-8?B?Z25VWG1GeG9HTy80YXN2SnR2VlVhbXVqc3NsSWpMTkxtdnRJN0d5UllLZE9v?=
 =?utf-8?B?RTlvNHdJSHQ3MnJBK2xwVytKZ0lVRjY5Y1FoUjJXWGZYU2lVKzZUa05PMjRW?=
 =?utf-8?B?d1RNQWdxYlJlN3dLRVgwNnlrcXJKRGJjM2djZmV5b0xCdVdVRXViQysxdHNX?=
 =?utf-8?B?cUhKK1Y4WDI3UjFQNmZhSzlpTVhJcTlxSU14OGhIWTVYYlQ1RTJIRXBYSFll?=
 =?utf-8?B?ellKam9MbWFqdW9wUzN6SEtsV1VJc2x0b2o2V0p1REgyYkZraFpFTnIzYTh4?=
 =?utf-8?B?S1Q4OEtBOHlTRTQvSmZxaVR6ekoxUDkza20xZWsyZUNXNjI4ZElvSWpBN056?=
 =?utf-8?B?eDBFRTVvSFh0R09zS2FOaFlKam1NbWpMN3VhS1Y2M0syNFROdzhpRVFnR1lO?=
 =?utf-8?B?VVVXM29aWmZpWDI1WXRYUzZNZStOOTNxZTJ6VHlYVFA4SlRvY3FLMmFHZFJx?=
 =?utf-8?B?cEtrSlh6cm15UDBzR1dJamlSQi9nSmpTZmE5ZkdTUXJlQVBJYVVSUkZtK1l4?=
 =?utf-8?B?bThxYWQvTUxXVGJlamdKM1E5eDF6S2hRb0JqeTBpVDV1aE9tcWF3Z0tBTHBj?=
 =?utf-8?B?YUF2S0IrU2xwU01sc2VMaks2RGR0Ykp5WFM5S3BkUnRFSTRjTHVPOFdQWkRy?=
 =?utf-8?B?VU9UQlF6TlVjbDZpaWErZVpQOW1YdDNLVUdxU0RpWGg4d0pLQWhsQnRTS25H?=
 =?utf-8?B?NmNBWUpodDdwOFZnOVArbSt0VHNsaGR3ZjhuaE5GR2t5bWNzZTVQWlpQczYy?=
 =?utf-8?B?SnFYLzVOaHBXbmYwcmxXL3oraUJKWVoxQkJTbmtUQTdTWk5lenlBbUYxUXY0?=
 =?utf-8?B?Mk1JNzRTRUZjaCszQ25sVEczYlMrTjdscGJObG5GcnM3ZndLUU55K3VhbGh6?=
 =?utf-8?B?V3o0a2NIU3VQVUxzRzVWZ0Fhc3pUU1dkWk5UZ3A5MGQ3QmVMb05aS24ydkVC?=
 =?utf-8?B?NFlhS1lwd3BTcERLM3hucVg1L0YyZ1pCZjBmYmhGNXhGVlByZW0zQmR0SUF6?=
 =?utf-8?B?eXU0R2VoOWNscXlHOXMzVjE4aTFMOU5qNFlTTUJ6WCtvcUdDQk5zbytuZGtl?=
 =?utf-8?B?ZE1Jc1d5TmlrSDg4WEVqSmFkUDdKRW5pREVsOHloOHBEajIwcXRLcjVFbFVw?=
 =?utf-8?B?Y21tc2NVZ3pJY0M5TzBCSzJ1dWZTUEYyellQbDgvVmc5YlBEMitjVFJjWjdp?=
 =?utf-8?B?UVc3bjBNQmZBeEVLaGlpemM4VW15T0pqMER4ZC9icnZxaDFIbmNxeHBRMVNm?=
 =?utf-8?B?Lzd1YTdDdllvT3Zsd3d3b09ydEw3R2QrVHZPTlNudTBzeHBEeVgyTGh0NnpP?=
 =?utf-8?B?dVFZWEtMTzBMSWpTUE5KdnM5enlZSzZIdFFkY2NqR0NnQnBaM3habXk5Q0h2?=
 =?utf-8?B?UHNqY3diWlhPY2JLcEprT0lzVStJdVNXTW1xWWVlSTRWMW9SWnNycjM2TDhX?=
 =?utf-8?B?QXB5ZnI1TEkwOStLR245M2JjaktMTENUMkVvT3ZlTWVnbXJ5cG1uMWlQOHdJ?=
 =?utf-8?Q?4PKeI6TWwu3vatoDWZU6r1kJq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF9765AF5DFE0A469CB7F5F356E0B2C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cUtpT2k3V3I3RTRITm9vMWdvVzJtdnBOLzlkWm5aRFJ6d2hPUGxzS095d1h2?=
 =?utf-8?B?WXg5OVMxT0VFUEtHK0hwK1hEV1RETzVKK1RodWowUTcyd1VIRlpNbkpSUWVQ?=
 =?utf-8?B?b0ZPVGloVG1iR1Z6d0xONGd4ZGg5cXZrRzJJWjA1SHpvVDFsUjY2bHZDcmVS?=
 =?utf-8?B?NUJXVGxBSkUvaGlLbVk4WUE3RUtQRXJvNkVkenFsc3JUa3NUTDkwUE9yajVB?=
 =?utf-8?B?NmVwM1lSaW1RamhRdGFQeXY3dnhnV0VTeVk1cFlONHRxVHozWlVBaFpjaDhq?=
 =?utf-8?B?ekdnUUFoUVIwRW9QdG9jU0RqaUpQQXhXcW1va09oOUF5YVhHTEFLUTJINGhS?=
 =?utf-8?B?UEhFb3hrQ0ZEMFdROEg2ZDBFZTRFNXpaUFlzaDFMSFp1b1FRMG5OaEJ6RG1X?=
 =?utf-8?B?dGoza21Hc2tOd2NjWXJDa3R3UDFENWJweVFJUzIvSUVEVVZZZS8xSzVIa0RB?=
 =?utf-8?B?VnRuek9PZ0ZSV2FXcHMrSEpCYzNwaXlPVkhTNEpRTDJFa0RiMWRDdkE4dWJC?=
 =?utf-8?B?N2pxTVowR2VrUzFLTVhaQVZJVkJTSkNQQzh2amRGWlp4ODFSOG5heHZOUjZi?=
 =?utf-8?B?R01La0NSMThSK2N0bVNCS3dTd3dHVmhlRVZ1dis1TWFTd3NEa201UEpaaWVE?=
 =?utf-8?B?WkJxZEJjVmN3TFZmdFNlcXRpNDBHbXBoSGpFSzQ0UjIxTU51UHVQcUJmZ1hV?=
 =?utf-8?B?RVpsNDJWYjhuaGNTeXY0TFNRVjQ4OUtCcU9lZ3NpNnlwQzRnZ0UyRU1rTlVO?=
 =?utf-8?B?VjJjeGZNMml5ejYwR2pBNWprQjVmVWZLTXdQZTVmd2Y0NXNjTVlJVEQrTXEz?=
 =?utf-8?B?TTQrNWFxVlNFa28xbmNSZnEyWndiQUs2NTlaM1FtajdxU0pWWjRXYlZBRlNi?=
 =?utf-8?B?RDJSTkQ4aTBwZzZSd2hOTW5FQndJWEgzdVovV21rTElTeEZQMFI3YWVuM21u?=
 =?utf-8?B?MWUwVVB3ZGlVbXNqODR0MlBiZE50Z3I0alRFbDZKZG1tT1hGSkJSd3lpSk1T?=
 =?utf-8?B?Q3kvSkpLMGhMaDZBWEFoeVg5ejd5L3RIMXNJeGRsUVVLK2c3blpKMExtZmw0?=
 =?utf-8?B?eEpORS80bXFBSUNZbExkODgxVU5XUTlHWXYzUS9xRlc3NTgvbC9McXN3WXpJ?=
 =?utf-8?B?UDVOdXZxcWhpa0FIbHVMZlluZFVMUXJxN1VFQ0JkRUZWYzRpdnJxZHRHK1RW?=
 =?utf-8?B?RDRSa2dQLzFEVXh0bDh2YnZIaXZMQkR4NGdodmNaWW90L2JtazZpVWVZYVYy?=
 =?utf-8?B?a1lNT04rVXEzU0h2ckdGZkN6YVB5aTI3Tnd0bWxmU2QyQ2pRbWxsTFF1OW94?=
 =?utf-8?B?V0dDZEFCQm8xR3laSHd0K3ZiQ0U1U2ZoSlZvZk5lTGV2enFZSVFvWWVoWFlz?=
 =?utf-8?B?ZFBHZUNzajdlYnc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248d611d-a2dc-43c4-6a64-08db6849d00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 17:57:23.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1Hp/pvnQiV4Sam6PqjoH8X6eFUll71I5ooCaDfv2XkbgnHqCwVbrs0r2JVOvhIbBOPh5h3McbqgSNXr8p61kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
X-Proofpoint-GUID: nct5g5QbcXGrepP1Es8hGB6cweG3eulP
X-Proofpoint-ORIG-GUID: nct5g5QbcXGrepP1Es8hGB6cweG3eulP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_13,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdW4gMDgsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNi84LzIwMjMgMzoxMiBQTSwgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiA+IE9uIFRo
dSwgSnVuIDA4LCAyMDIzIGF0IDAxOjIxOjAyQU0gKzA1MzAsIEtyaXNobmEgS3VyYXBhdGkgUFNT
TlYgd3JvdGU6DQo+ID4gPiBPbiA2LzcvMjAyMyA1OjA3IFBNLCBKb2hhbiBIb3ZvbGQgd3JvdGU6
DQo+ID4gDQo+ID4gPiA+IFNvIHRoZXJlIGF0IGxlYXN0IHR3byBpc3N1ZXMgd2l0aCB0aGlzIHNl
cmllczoNCj4gPiA+ID4gDQo+ID4gPiA+IAkxLiBhY2Nlc3NpbmcgeGhjaSByZWdpc3RlcnMgZnJv
bSB0aGUgZHdjMyBjb3JlDQo+ID4gPiA+IAkyLiBhY2Nlc3NpbmcgZHJpdmVyIGRhdGEgb2YgYSBj
aGlsZCBkZXZpY2UNCj4gPiA+ID4gDQo+ID4gPiA+IDEuIFRoZSBmaXJzdCBwYXJ0IGFib3V0IGFj
Y2Vzc2luZyB4aGNpIHJlZ2lzdGVycyBnb2VzIGFnYWluc3QgdGhlIGNsZWFyDQo+ID4gPiA+IHNl
cGFyYXRpb24gYmV0d2VlbiBnbHVlLCBjb3JlIGFuZCB4aGNpIHRoYXQgRmVsaXBlIHRyaWVkIHRv
IG1haW50YWluLg0KPiA+ID4gPiANCj4gPiA+ID4gSSdtIG5vdCBlbnRpcmVseSBhZ2FpbnN0IGRv
aW5nIHRoaXMgZnJvbSB0aGUgY29yZSBkcml2ZXIgYmVmb3JlDQo+ID4gPiA+IHJlZ2lzdGVyaW5n
IHRoZSB4aGNpIHBsYXRmb3JtIGRldmljZSBhcyB0aGUgcmVnaXN0ZXJzIGFyZSB1bm1hcHBlZA0K
PiA+ID4gPiBhZnRlcndhcmRzLiBCdXQgaWYgdGhpcyBpcyB0byBiZSBhbGxvd2VkLCB0aGVuIHRo
ZSBpbXBsZW1lbnRhdGlvbiBzaG91bGQNCj4gPiA+ID4gYmUgc2hhcmVkIHdpdGggeGhjaSByYXRo
ZXIgdGhhbiBjb3BpZWQgdmVyYmF0aW0uDQoNClRoZSBjb3JlIHdpbGwganVzdCBiZSBsb29raW5n
IGF0IHRoZSBIVyBjYXBhYmlsaXR5IHJlZ2lzdGVycyBhbmQNCmFjY2Vzc2luZyB0aGUgcG9ydHMg
Y2FwYWJpbGl0eS4gT3VyIHByb2dyYW1taW5nIGd1aWRlIGFsc28gbGlzdGVkIHRoZQ0KaG9zdCBj
YXBhYmlsaXR5IHJlZ2lzdGVycyBpbiBpdHMgZG9jdW1lbnRhdGlvbi4gV2UncmUgbm90IGRyaXZp
bmcgdGhlDQp4aGNpIGNvbnRyb2xsZXIgaGVyZS4gV2UncmUgaW5pdGlhbGl6aW5nIHNvbWUgb2Yg
dGhlIGNvcmUgY29uZmlncyBiYXNlDQpvbiBpdHMgY2FwYWJpbGl0eS4NCg0KV2UncmUgZHVwbGlj
YXRpbmcgdGhlIGxvZ2ljIGhlcmUgYW5kIG5vdCBleGFjdGx5IGRvaW5nIGl0IHZlcmJhdGltLg0K
TGV0J3MgdHJ5IG5vdCB0byBzaGFyZSB0aGUgd2hvbGUgeGhjaSBoZWFkZXIgd2hlcmUgd2Ugc2hv
dWxkIG5vdCBoYXZlDQp2aXNpYmlsaXR5IG92ZXIuIFBlcmhhcHMgaXQgbWFrZXMgc2Vuc2UgaW4g
c29tZSBvdGhlciBkcml2ZXIsIGJ1dCBsZXQncw0Kbm90IGRvIGl0IGhlcmUuDQoNCj4gPiA+ID4g
DQo+ID4gPiA+IFRoZSBhbHRlcm5hdGl2ZSB0aGF0IGF2b2lkcyB0aGlzIGlzc3VlIGVudGlyZWx5
IGNvdWxkIGluZGVlZCBiZSB0bw0KPiA+ID4gPiBzaW1wbHkgY291bnQgdGhlIG51bWJlciBvZiBQ
SFlzIGRlc2NyaWJlZCBpbiBEVCBhcyBSb2IgaW5pdGlhbGx5DQo+ID4gPiA+IHN1Z2dlc3RlZC4g
V2h5IHdvdWxkIHRoYXQgbm90IHdvcms/DQoNClNlZSBiZWxvdy4NCg0KPiA+ID4gPiANCj4gPiA+
IFRoZSByZWFzb24gd2h5IEkgZGlkbid0IHdhbnQgdG8gcmVhZCB0aGUgUGh5J3MgZnJvbSBEVCBp
cyBleHBsYWluZWQgaW4NCj4gPiA+IFsxXS4gSSBmZWx0IGl0IG1ha2VzIHRoZSBjb2RlIHVucmVh
ZGFibGUgYW5kIGl0cyB2ZXJ5IHRyaWNreSB0byByZWFkIHRoZQ0KPiA+ID4gcGh5J3MgcHJvcGVy
bHksIHNvIHdlIGRlY2lkZWQgd2Ugd291bGQgaW5pdGlhbGl6ZSBwaHkncyBmb3IgYWxsIHBvcnRz
DQo+ID4gPiBhbmQgaWYgYSBwaHkgaXMgbWlzc2luZyBpbiBEVCwgdGhlIGNvcnJlc3BvbmRpbmcg
bWVtYmVyIGluDQo+ID4gPiBkd2MtPnVzYlhfZ2VuZXJpY19waHlbXSB3b3VsZCBiZSBOVUxMIGFu
ZCBhbnkgcGh5IG9wIG9uIGl0IHdvdWxkIGJlIGEgTk9QLg0KPiA+IA0KPiA+IFRoYXQgZG9lc24n
dCBzb3VuZCB0b28gY29udmluY2luZy4gQ2FuJ3QgeW91IGp1c3QgaXRlcmF0ZSBvdmVyIHRoZSBQ
SFlzDQo+ID4gZGVzY3JpYmVkIGluIERUIGFuZCBkZXRlcm1pbmUgdGhlIG1heGltdW0gcG9ydCBu
dW1iZXIgdXNlZCBmb3IgSFMgYW5kDQo+ID4gU1M/DQo+ID4gPiBBbHNvIGFzIHBlciBLcnp5c3p0
b2Ygc3VnZ2VzdGlvbiBvbiBbMl0sIHdlIGNhbiBhZGQgYSBjb21wYXRpYmxlIHRvIHJlYWQNCj4g
PiA+IG51bWJlciBvZiBwaHkncyAvIHBvcnRzIHByZXNlbnQuIFRoaXMgYXZvaWRzIGFjY2Vzc2lu
ZyB4aGNpIG1lbWJlcnMNCj4gPiA+IGF0bGVhc3QgaW4gZHJpdmVyIGNvcmUuIEJ1dCB0aGUgbGF5
ZXJpbmcgdmlvbGF0aW9ucyB3b3VsZCBzdGlsbCBiZSBwcmVzZW50Lg0KPiA+IA0KPiA+IFllcywg
YnV0IGlmIHRoZSBpbmZvcm1hdGlvbiBpcyBhbHJlYWR5IGF2YWlsYWJsZSBpbiBEVCBpdCdzIGJl
dHRlciB0byB1c2UNCj4gPiBpdCByYXRoZXIgdGhhbiByZS1lbmNvZGUgaXQgaW4gdGhlIGRyaXZl
ci4NCj4gDQo+IEhpIEpvaGFuLA0KPiANCj4gICBBcmUgeW91IHN1Z2dlc3RpbmcgdGhhdCB3ZSBq
dXN0IGRvIHNvbWV0aGluZyBsaWtlDQo+IG51bV9wb3J0cyA9IG1heCggaGlnaGVzdCB1c2IyIHBv
cnRudW0sIGhpZ2hlc3QgdXNiMyBwb3J0IG51bSkNCg0KV2h5IGRvIHdlIHdhbnQgdG8gZG8gdGhp
cz8gVGhpcyBtYWtlcyBudW1fcG9ydHMgYW1iaWd1b3VzLiBMZXQncyBub3QNCnNhY3JpZmljZSBj
bGFyaXR5IGZvciBzb21lIGxpbmVzIG9mIGNvZGUuDQoNCj4gDQo+IElmIHNvLCBpbmNhc2UgdGhl
IHVzYjIgcGh5IG9mIHF1YWQgcG9ydCBjb250cm9sbGVyIGlzIG1pc3NpbmcgaW4gRFQsIHdlDQo+
IHdvdWxkIHN0aWxsIHJlYWQgbnVtX3VzYjJfcG9ydHMgYXMgNCBidXQgdGhlIHVzYjJfZ2VuZXJp
Y19waHlbMV0gd291bGQgYmUNCj4gTlVMTCBhbmQgYW55IHBoeSBvcHMgd291bGQgc3RpbGwgYmUg
Tk9QLiBCdXQgd2Ugd291bGQgYmUgZ2V0dGluZyByaWQgb2YNCj4gcmVhZGluZyB0aGUgeGhjaSBy
ZWdpc3RlcnMgY29tcGVsdGVseSBpbiBjb3JlIGRyaXZlci4NCj4gDQo+IFRoaW5oLCBCam9ybiwg
Y2FuIHlvdSBhbHNvIGxldCB1cyBrbm93IHlvdXIgdmlld3Mgb24gdGhpcy4NCj4gDQo+IDEuIFJl
YWQ6DQo+ICAgbnVtX3VzYjNfcG9ydHMgPSBoaWdoZXN0IHVzYjMgcG9ydCBpbmRleCBpbiBEVA0K
PiAgIG51bV91c2IyX3BvcnRzID0gbWF4KCBoaWdoZXN0IHVzYjIgcG9ydCBpbmRleCwgbnVtX3Vz
YjNfcG9ydHMpDQo+IA0KPiAyLiBSZWFkIHRoZSBzYW1lIGJ5IHBhcnNpbmcgeGhjaSByZWdpc3Rl
cnMgYXMgZG9uZSBpbiByZWNlbnQgdmVyc2lvbnMgb2YNCj4gdGhpcyBzZXJpZXMuDQo+IA0KDQpE
VCBpcyBub3QgcmVsaWFibGUgdG8gZ2V0IHRoaXMgaW5mby4gQXMgbm90ZWQsIHRoZSBEVCBtYXkg
c2tpcCBzb21lDQpwb3J0cyBhbmQgc3RpbGwgYmUgZmluZS4gSG93ZXZlciwgdGhlIGRyaXZlciBk
b2Vzbid0IGtub3cgd2hpY2ggcG9ydA0KcmVmbGVjdHMgd2hpY2ggcG9ydCBjb25maWcgaW5kZXgg
d2l0aG91dCB0aGUgZXhhY3QgcG9ydCBjb3VudC4NCg0KTW9yZSBpbXBvcnRhbnRseSwgdGhlIGhv
c3QgY29udHJvbGxlciB0aGF0IGxpdmVzIG9uIHRoZSBQQ0kgYnVzIHdpbGwgbm90DQp1c2UgRFQu
IFRoaXMgY2FuIGJlIHVzZWZ1bCBmb3Igc29tZSByZS1jb25maWd1cmF0aW9ucyBpZiB0aGUgY29u
dHJvbGxlcg0KaXMgYSBQQ0kgZGV2aWNlIGFuZCB0aGF0IGdvZXMgdGhyb3VnaCB0aGUgZHdjMyBj
b2RlIHBhdGguDQoNClRoYW5rcywNClRoaW5o
