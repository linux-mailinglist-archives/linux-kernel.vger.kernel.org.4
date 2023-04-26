Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245716EEBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbjDZBEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbjDZBEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:04:50 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24AAB23B;
        Tue, 25 Apr 2023 18:04:47 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PNFp7k014376;
        Tue, 25 Apr 2023 18:04:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=NXzu6PctxUoRQk10RC1jG4VBSreYoaJ7lw9VraKRAxk=;
 b=GLmptE2dwTxAdLC5snXp9dKQuHc4SIlrTFjAg1rSYjAeDrDmtqH/4fBAyAOKoZubp3N8
 +5ixAhYXRb67PNyHTEWx+wYjWzg9vjGC7dxw1MTElNjTFJ9h/cJQbth6Ug/GaKDc4jcJ
 TLfcwCTHKrMw/pktnGpbU1h54Bp21DySi3cPnP8hQSo2l2EklKdRxIbF+y/5ukvmgOuZ
 Nw9eD02kJHJUtLOO2JUIlLJLkpz8vrNd5Mzma6xKtWHJhYHieTA1ipkys3pYkwevMVNb
 mwOCe97I7lPOiD+as9h5ttf3M/ipi6Us9mY//cUzkVRNmdqWuP7wXKAzJvzVAhLdPFev FQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q4eu6pfdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 18:04:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682471058; bh=NXzu6PctxUoRQk10RC1jG4VBSreYoaJ7lw9VraKRAxk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QAHq/qHAJZ43dqPfwTMZsiOzM91y/kDGnWePyrOyg1BOcwEn7qukTQ5202rTPJPOJ
         7JN48jUKGTuEO16c3k+o9rgO7xH1wXryrUWVGKbz9ateS4EAdROS8HdgMvQ7mYUKHC
         vBlZhfiK+R6Xd6hPSBYV/efDv/c9qczzbceAIPpO8IKG6IOvW+dxgCydP3EBZ1WfHt
         r2OM5sn8XehIPNOnXp8Nq7cPhjQoYEY0I102HuZLGsoT7vyifOVDZ5t8n3e7Fk34Z5
         LDSKM/JC6Y5qiH/pjL0RSU5SxcB1cV+NfkOP7rElkqE9XBKq3TRvHc+znBgVkQcaqH
         hdHzMG1uMatjQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B128D40523;
        Wed, 26 Apr 2023 01:04:17 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id ACEB2A0083;
        Wed, 26 Apr 2023 01:04:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=oiL53qbK;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 32D7F4045F;
        Wed, 26 Apr 2023 01:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3Z7w8ZRybxCdNOuvdtpXECxp5/ZpOsSd84+YkjhJI7IEynL131ckK6IVx5R4JQ2MQxnC1haJdJ7Y66ePV5OpQ4BCG6B714Jf0kSg3PshAHIi7l6w54b87Vmx+2wzai96S3giERR7obfGDHtOuOvpgTJJcyX5q/97ujLAshksOQI+h2E5JJ5O64ejR46NSKUN1BUMqAZKZaC8EbXGdvz/D5TApE9Kc4OCZS1CMTa/q5EzubijyKYKUEtDT1nDaTcpEOPyYIxi/8kflKqjMLneQB1qBBLRp4T7eAY2YZI23lduZfaQUhIelgeC45HcRNDFL5Stk/103kbhfusNOsM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXzu6PctxUoRQk10RC1jG4VBSreYoaJ7lw9VraKRAxk=;
 b=MT2hEbnfGQY1jlt3l/fVCW3UiZBcmN6JcWy8cjdBbOz3CvdTktVyzWIpJEtFy7EduFBnFjk4/IM1eNK3uaIO+Sr/CsAvdS5QPsA4SYSV1tBCyCFycc+D3TfZmqQjIOlHUeiG8lY1O3rptvmn5j06DmH/vQsaEf30ZdG50jOqvWVH8WHPdYAeZX516H5k4naxmSlx0Lez02upILruZqt/EvWyRd9fLesyOMkyxS0fKG1yw3YhcTFvRA36LvUk8bc2JaJWVm+dO6TzIrmLM+QW9ia/+qPUCpZWcOBlU2me8xeteii+gpTMaiYUBxfRTrcQl97vUeo4zRGE+xx2+HF/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXzu6PctxUoRQk10RC1jG4VBSreYoaJ7lw9VraKRAxk=;
 b=oiL53qbKl6MqUIxzPgUEwMiSOHTvd0CTECtz3ATXu3F8IcpGd+cSAk0TPwLvfes2w8Yt5swuIkg2rrDqHIYRsXGob2Qjj8OzSHWrNX35VNfFvxBwreI5K7nOY8ttykg9lck+uL+fZcKkZMUERhjn1VhtIuqZbkUpcILoIve+puk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 01:04:09 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d%7]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 01:04:09 +0000
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
Thread-Index: AQHZYY+ZaTJWoGmlmk+xC9kJuoh9G68QszUAgAB5QYCAAUhdgIABGcUAgAa8LoCAAFDhAIABHkyAgABv8wCAAVUPAIAAGQyAgB7TP4CAAHv+AIAABdIAgAAF0AA=
Date:   Wed, 26 Apr 2023 01:04:08 +0000
Message-ID: <20230426010406.d3v4tsubcf2dju6t@synopsys.com>
References: <4f473d08-156a-622f-2ef2-ad11caa7ccda@quicinc.com>
 <20230403234937.sotn3pznu4winlkw@synopsys.com>
 <e769cc7c-8b87-c346-5cef-9d89f3ccb91e@quicinc.com>
 <20230404214347.mi6rmksr7pym74rp@synopsys.com>
 <f334b8b9-b8d8-240d-5ace-bed255f4609a@quicinc.com>
 <20230406004510.yxoxby2rwkalpqlh@synopsys.com>
 <e5e82a2f-dd89-bdfc-f521-c9d2543a139a@quicinc.com>
 <55cfaedc-bd33-610c-143e-0342a14a41b6@quicinc.com>
 <20230426000336.3yr2zydcniboe65k@synopsys.com>
 <f29fb5ae-0e49-403c-487a-c9380603328a@quicinc.com>
In-Reply-To: <f29fb5ae-0e49-403c-487a-c9380603328a@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB7713:EE_
x-ms-office365-filtering-correlation-id: bce5aef4-42c6-49a4-c1f0-08db45f223d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFkAxIiakRGUTz3kkDFB2HHZVZgWZaPjXZxVN890eI8tC0tNZ4qhDVl1NduNyZletRmPNL+hlHe0WqufoANBwsWF9+aYrVJBelJ3mNcbEZxbScprUknIea/conMhhjVUseT04k+fdE3j+hFsPSU+I7Hrawqxl4A3qtru2Auj5B9yqv7aTQo+vsRB5Zk+0mGt9HZ1kuza4FjRB3q7wcFdRxutZWEGKu5zjGExOF5MhKWJ0F7Ch7x16yswayLYLtIK3dmwo1aurvDWjS4qZ8FSOSCkuer3u1UqPMIyMxi8A19sT2/LnT1N5DXqy1bDwU+gqJpMZox8a/MhAK7mfc+ZQpGsMlnsiBZeB4CECA6l6Iy3IjiJd5NNxZMnKlzPykU9vObOmMz3EZEj0hxwNikFtFxfBt7kJS3y3uQYh5wiBl2Geqz6Mk3Gau3kD86J1j0Ykf/lMVQJ3jZF2lm8gYh2OBTlwfwjfpEub3xGCD/xFUcF4/f+Cmkn742wBRs5Q/BIzvH9ty5tQfagiAobw3VraUMcYIaIytN2Yf4sR1YOF/056wo0NhAKx5pctezJApvwMelOEnOf4MFEL4KhVK9P37vzYT5WWnLk6aRMiYIVGUaGATg/TSR7x3deQZIRNNGa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(66899021)(6916009)(4326008)(316002)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(36756003)(186003)(6506007)(53546011)(6512007)(1076003)(26005)(86362001)(122000001)(2616005)(38100700002)(83380400001)(5660300002)(41300700001)(8936002)(8676002)(478600001)(6486002)(71200400001)(38070700005)(7416002)(2906002)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFVQTmJjR1J1TmpwZW5XTlFHYnkzVzhMQ2N4b0RpMC9uVkU0TUt0TUVqb01m?=
 =?utf-8?B?YjRLM2t6RlBEL2pUQ0FkdTJtUVlWNFhBZktGcGxibzlWTnBWTHAwYkNwWHpH?=
 =?utf-8?B?Z3l1a09ueFpPSkZmSVVVNXpxeG8ybmp0K09WS1R3dXJNOUhVTzRKSGI1WTFN?=
 =?utf-8?B?ZGVuVG5rbVpBSnVLOThZMzBwZTdRT2cyWGFFYjEwZkd6dGVpZ3R2QS9PdUdp?=
 =?utf-8?B?MktnNEwyS3VFVWhrZlBQdzEySFF4bjZvaE1sVlM1NCtHV1AzV2RLcC9MSnJa?=
 =?utf-8?B?VVdFVXhZZlZUQTlyZ2lEOUxNc2krOFUrUmNETXg0WlFPZGtPR3lBVWlnTldj?=
 =?utf-8?B?SkhjSmRBVU5hVi8rdGh1ekpGc1JkVnJUVnBGN0JIRmJzQm9iMWNxQzN4UnBn?=
 =?utf-8?B?UjBhT1hwbkNpUjdkRkxDaW1KZUlodXNzbHZJY1ByNjgzOWhwVW40VHh5My9Z?=
 =?utf-8?B?VExiYzMrd0IwaEJpbzdUNncvWHAySkFHTzlQd2Fmb2lEMlRhZFJCMW5ZL2VH?=
 =?utf-8?B?ekhlcFJQU3B0Y1NNVEdlL1RlanFrdUptVmlDVUVVZHJySDJORlJvdjNmTVdu?=
 =?utf-8?B?czRGUVJ3dkxZTTFaK1MxRjVJZFBTMCs4R05MaXNxd2RFWWZVT1dQNks1THBD?=
 =?utf-8?B?YzZ1SWhZWUFpTmZvcStqSmVFVHp2SnVGV3NYbncwWURtRTIvdXRvU0EzMTFS?=
 =?utf-8?B?cWw2TG5zV0lCZzFJZTg0RS9HenVsak53bzloTEM1L2hHbThtVWliY0ZGTXF5?=
 =?utf-8?B?ak5DR2gvRUpCV0hVZlQrNVZDdFdxa3F1TGVPd0s0K2FMR0JVQWRqTG1Vb0hR?=
 =?utf-8?B?enZtMUs5NDJlam9LSmRKQzhmZVExYk5jYit0WGV5WmpXOUd6cGlJTnptZWJT?=
 =?utf-8?B?b1FybXpEeUxLeUVKR1JEVVFXYkFEQWNWZVFzby9SRkRuNDRBSEprRUIwTThp?=
 =?utf-8?B?cmY2Z3BVWHFOM20xbUVhRSttVitrWnMrR3llS01sMENselh0Y1BKVlhnQTJs?=
 =?utf-8?B?N1JocVl5WXZybFYvTDFFUHRCRDAvT2EyZXNDelpmY3JyUnpIRFc4Zk5vSG4x?=
 =?utf-8?B?ZHdjdWJDSjk0Mk1SZitvVUdDVmZPRkxEc2hybHJOYWVJY0hTQW1hTkp0aHVV?=
 =?utf-8?B?aXVuSTV5eWhIWm9WL0xHaldZYUk3M0RXcUhRcnJOa25CbDQvQXZQL3VOM09U?=
 =?utf-8?B?eGRRbVV1bTdQZ2VOY1dWNWgwVDBEZnJKRERLMEs2M0VWTXN6YVJsRE9VeVF0?=
 =?utf-8?B?N3I3OGZlWXNJTHNYM2xGVWVxZU1uckRyZXNCNUYwVHBGdkxoaG1STS85NkI5?=
 =?utf-8?B?QklJYzdUQXJJTndCMGk0WkErMXdmbEY2b1JwL1NhN3VzZVEzSkxZMERsaXZr?=
 =?utf-8?B?a0E5M29kWmpXeVNlYnhrSUo0UkxQUTAvYWY5cWVlQ1R1bU9VbGJ2NTJUQ1lW?=
 =?utf-8?B?allIamtuZm9zMi9DZmFXSkxVc0NqRkxCTDhnTzJZSnUvRGMra1g1LzdQMllq?=
 =?utf-8?B?eTFWK2pPSWtnZkNTVjEyYVlTeGVITmwwdUdCVkoydVZib201S21LZjliOGNV?=
 =?utf-8?B?U2M1T2RCTVVOZmhrM1ZXVkxkSUVwcERTKzdIeElRcVJlUCtPSFh4czd1OTJ3?=
 =?utf-8?B?U2U0VEFOVDVEL2tkTnNuOUlQSXFMd25wWFpyNlJDMGhlS3AxS1NPdkNZVDNM?=
 =?utf-8?B?SDl1TUVwekRRVEpCTnEza0VwUjh5cmVtUHpBK1RZU3JzNHdXZHJkOEc1K0F5?=
 =?utf-8?B?T25DUXk2Vm1JU1RNTktGOTFIdzI3OEIwZkswVEd1bDlWbGhteDlHZElmREtI?=
 =?utf-8?B?eG9YTEZ6SVFobUxrUDZJSHJDdmM0UzVyY3lreDQ2REdDS0xJOHJXeFlyZnVG?=
 =?utf-8?B?c1d2b1FFTlhrWlcwV25XRmtCallZaWEycHQzVGsxZ0piQzM3Y0VUTnE3c3NB?=
 =?utf-8?B?MWNmTC91c1N0VWE1SUZTbVVOQ25hUlZiekh4cldhUWpGVUM1dmpwbi8xRnhZ?=
 =?utf-8?B?b1NDdFVjSk5JYUlQWmIxZC9iK0J3aUp1a2N4VHBQeVpDL3ZJNE5qbTJDeExM?=
 =?utf-8?B?dHMxUFJOZnd0WXRLdjA4d2ZFbkRTVUhCQkR6S0lCRG1ya2lYc0haL25EYjFm?=
 =?utf-8?B?ZlltQnI5elJoOU9YZXROZnRLb3VrZ1M2bml3VlNTcWlBc0d6SDVzak0vT2FX?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0D08BAC57A1FD4C851D16BDFADF25AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UHlDWHJ1QzFYcis5T1BJQ3hCQkZzNitmWmdTMkNDRmJFRXpYZTNIRHlPc1l2?=
 =?utf-8?B?UXNBTVlxU1N5NU80a0VtbXNvekp5YWY3dW8xTzRIVDdFQzRLUFB4VzZIbHgr?=
 =?utf-8?B?SFZVRmkrOHFMcnBPeVlZcW84SWVKK051TWU0OHk4Kzh2MTJXM3ZUZktYQnJF?=
 =?utf-8?B?Vnd4NGZLTGlvTG1VQ0lqM2IycU9QbWx1ald0cUNmTzdWbmQ1dDgxTjBkcHdV?=
 =?utf-8?B?Tkg1UUZNZWg0aTlaREZTYmY0NlRkKzA0QWphSncvV2VzbEt3SWpWTlJoa3Fy?=
 =?utf-8?B?WFZRdDRqc0VtSTQ2U2dqWjg5eFVWNHlBeGs1NTZwMDZFQ2hqSnNPOXk5MjJ0?=
 =?utf-8?B?Q0Fab0loeDFhakpPU2FHTVRwVDB6cDIxU1pNN1JORnd4cDNyRytPUlA0d09w?=
 =?utf-8?B?MXFFTzd1OEJWd09BVjEyZU9lVGJ3T2swTjVwVThHUCtCZnBSL0dTZXEybDlo?=
 =?utf-8?B?U21tUjE2WmFJS0g0b0krV29vak52MEp2V0NHK01TZ2xaa2xvWmNQZ1RKaHlk?=
 =?utf-8?B?Rjdoc1R1bERISm5wb3d2R2hyUENQeDVzcVk4UEtHbWxiWFkyNE8vcTViWFNo?=
 =?utf-8?B?L1lRL0c1MHF1b001QWFuU2hGVEFFRXFxMDB1MTh0YzliRHgvRVhMVFpCdkJB?=
 =?utf-8?B?aVNqd0F5RlVIVFkxT2MwM3l6SjZLTDIwaDJDNWd3ZzRpZEgrQS9XbmdwVVo3?=
 =?utf-8?B?WmJFRDRYdU1nL3hPU3BGUktmeWhKb3dFUjVjYkFzei9ValN0UDk4Q3FhLzJK?=
 =?utf-8?B?VkV6V1M3TEF0SXh0ZUxudWFqOVJUTWpLUVRLQngwNlBRSGF0RmRCSmhsM1hq?=
 =?utf-8?B?R0ltZlpSbUtPRWF1WDBaSXVTaUhoN2FyaGloeWZEVjE1S1Z6TllTeXBiYUlw?=
 =?utf-8?B?QmFuMjE4M3V4ekgxc2V1a3F4MFcyMzlQcHZMTmhjMTZxVHhMWUZaVjJNeFdX?=
 =?utf-8?B?QjZ5RE9NV3BaUlRzMXBIU0wxTTdCRy9IclBWVlkxQzdrZkpXTU41eHZ6T2Iy?=
 =?utf-8?B?enpYaEllQWtGMkRIOUUybUZvOVJhekdGUFpoZm5vbEpwYldrVHQ0WXpUa2dh?=
 =?utf-8?B?dGJJbHZiSWFrN05Zek42YkVqK3lRQUlNUUptdk1yTzZyVGdiUHU2dVBpWUdQ?=
 =?utf-8?B?N0VKZzkzejJ2b1dVcTdvSU53Y2RpMzlHenpSYlZJaTl0empVNTlnbjBGRW1y?=
 =?utf-8?B?UzZMOHcrQmpMWU9tOFNYbUtSMjBoWlRBa3hKUWFnclkvdmcySXdDdFZRc3BE?=
 =?utf-8?B?VisxYTVTS2puN3N6bU50Y0dBSTRaTjZiYUpLSnNiRUFIUXJKSHlnRGVlekFH?=
 =?utf-8?B?U1pYaVVLMno3SDBlRzhpblA2OE9jL25TbDBzREdTSFlrdkNzZjBVRWo1Njh5?=
 =?utf-8?Q?VIR06eEolC4EghzOuSaNgAmVKHd1VleY=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce5aef4-42c6-49a4-c1f0-08db45f223d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 01:04:08.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPxSBDCPg8uBPXNivZwiZysXfb1xFzdAAtPkY4Ge1VhfZATwZppPyiT1xM2jG2n6OMXDPWzeDp22y6z8FIUCWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
X-Proofpoint-GUID: rlnYNowgbbKNPxuVHBtl-_fS-9ljvUE_
X-Proofpoint-ORIG-GUID: rlnYNowgbbKNPxuVHBtl-_fS-9ljvUE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_11,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304260008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMjYsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNC8yNi8yMDIzIDU6NTIgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBU
dWUsIEFwciAyNSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90ZToNCj4gPiA+IA0K
PiA+ID4gDQo+ID4gPiBPbiA0LzYvMjAyMyA3OjQ0IEFNLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05W
IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDQvNi8yMDIzIDY6MTUgQU0s
IFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQsIEFwciAwNSwgMjAyMywgS3Jp
c2huYSBLdXJhcGF0aSBQU1NOViB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBPbiA0LzUvMjAyMyAzOjEzIEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4g
PiA+ID4gPiA+IE9uIFR1ZSwgQXByIDA0LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdy
b3RlOg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+
IE9uIDQvNC8yMDIzIDU6MTkgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiA+IE9uIFRodSwgTWFyIDMwLCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3RlOg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
ID4gPiA+IE9uIDMvMzAvMjAyMyA1OjQwIEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gT24gV2VkLCBNYXIgMjksIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNT
TlYgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gMy8yOS8yMDIzIDI6NTAgQU0sIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIE1hciAy
OCwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBJZiB0aGUgY29yZSBzb2Z0IHJlc2V0IHRpbWVvdXQgaGFwcGVucywgYXZvaWQgc2V0dGlu
ZyB1cCBldmVudA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGJ1ZmZlcnMgYW5kIHN0YXJ0
aW5nIGdhZGdldCBhcyB0aGUgd3JpdGVzIHRvIHRoZXNlIHJlZ2lzdGVycw0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IG1heSBub3QgcmVmbGVjdCB3aGVuIGluIHJlc2V0IGFuZCBzZXR0aW5n
IHRoZSBydW4gc3RvcCBiaXQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjYW4gbGVhZCB0
aGUgY29udHJvbGxlciB0byBhY2Nlc3Mgd3JvbmcgZXZlbnQgYnVmZmVyIGFkZHJlc3MNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiByZXN1bHRpbmcgaW4gYSBjcmFzaC4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDC
oMKgwqDCoMKgIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1ICsrKystDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gIMKgwqDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBpbmRleCAzYzYzZmE5N2E2ODAuLmYwNDcyODAxZDlhNSAxMDA2NDQNCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEBAIC0yNjIwLDEzICsyNjIwLDE2IEBAIHN0YXRpYw0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGludCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdXNiX2dhZGdldCAqZywgaW50IGlzX29uKQ0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICoNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkZXZpY2UtaW5pdGlhdGVkIGRpc2Nvbm5l
Y3QNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiByZXF1aXJlcyBhIGNvcmUgc29mdCByZXNl
dA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogKERDVEwuQ1NmdFJzdCkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBiZWZvcmUg
ZW5hYmxpbmcgdGhlIHJ1bi9zdG9wDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYml0Lg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICovDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgIGR3YzNfY29y
ZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgIHJldCA9IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBkb25lOw0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MzX2V2ZW50X2J1
ZmZlcnNfc2V0dXAoZHdjKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX19kd2MzX2dhZGdldF9zdGFydChkd2MpOw0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBkd2MzX2dh
ZGdldF9ydW5fc3RvcChkd2MsIHRydWUsIGZhbHNlKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAr
ZG9uZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgIHBt
X3J1bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
LS0gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMi40MC4wDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBJIHRoaW5rIHRoZXJlJ3Mgb25lIG1vcmUgcGxhY2UgdGhhdA0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBtYXkgbmVlZHMgdGhpcyBjaGVjay4gQ2FuIHlvdSBhbHNvDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGFkZCB0aGlzIGNoZWNrIGluIF9fZHdjM19zZXRfbW9kZSgp
Pw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBIaSBU
aGluaCwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
IMKgwqDCoMKgwqAgU3VyZS4gV2lsbCBkbyBpdC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdp
bGwgdGhlIGJlbG93IGJlIGdvb2QgZW5vdWdoID8gT3Igd291bGQNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IGl0IGJlIGdvb2QgdG8gYWRkIGFuIGVycm9yL3dhcm4gbG9nDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiB0aGVyZT4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBUaGVyZSdzIGFscmVhZHkgYSB3YXJuaW5nIG1lc3NhZ2UgaW4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBkd2MzX2NvcmVfc29mdF9yZXNldCgpIGlmIGl0IGZhaWxzLg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBrcmlza3VyYUBodS1rcmlza3VyYS1oeWQ6L2xvY2FsL21udC93b3Jrc3BhY2Uva3Jp
c2huYS9za2FsZXMyL3NrYWxlcy9rZXJuZWwkDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBnaXQg
ZGlmZiBkcml2ZXJzL3VzYi8NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBpbmRleCA0NzZiNjM2MTg1MTEuLjhkMWQyMTNkMWRjZCAxMDA2NDQN
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTIxMCw3ICsyMTAsOSBAQCBzdGF0aWMgdm9pZA0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gX19kd2MzX3NldF9tb2RlKHN0cnVjdCB3b3JrX3N0cnVjdA0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKndvcmspDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBEV0Mz
X0dDVExfUFJUQ0FQX0RFVklDRToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBkd2MzX2Nv
cmVfc29mdF9yZXNldChkd2MpOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2Mp
Ow0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gSWYgc29mdC1yZXNldCBmYWlsZWQsIHRoZSBjb250cm9sbGVyIGlz
IGluIGENCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBiYWQgc3RhdGUuIFdlIHNob3VsZCBub3QNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBwZXJmb3JtIGFueSBmdXJ0aGVyIG9wZXJhdGlvbiB1bnRpbCB0
aGUgbmV4dA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGhhcmQgcmVzZXQuIFdlIHNob3VsZCBmbGFn
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhlIGNvbnRyb2xsZXIgYXMgZGVhZC4gSSBkb24ndCB0
aGluayB3ZSBoYXZlIHRoZSBlcXVpdmFsZW50IG9mIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IGhvc3QncyBIQ0RfRkxBR19ERUFELiBJdCBtYXkgcmVxdWlyZSBzb21lDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gd29yayBpbiB0aGUgVURDIGNvcmUuIFBlcmhhcHMNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiB3ZSBjYW4gZmxhZyB3aXRoaW4gZHdjMyBmb3Igbm93IGFuZCBwcmV2ZW50DQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gYW55IGZ1cnRoZXIgb3BlcmF0aW9uIGZvciBhDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gc2ltcGxlciBmaXguDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+ID4gPiA+IEhpIFRoaW5oLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiA+ID4gIMKgwqDCoCBBcmUgeW91IHJlZmVycmluZyB0aGF0IGlmIF9fZHdjM19zZXRfbW9kZQ0K
PiA+ID4gPiA+ID4gPiA+ID4gPiBmYWlsZWQgd2l0aCBjb3JlIHNvZnQgcmVzZXQNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gdGltaW5nIG91dCwgdGhlIGNhbGxlciBpLmUuLCBkd2MzX3NldF9tb2RlIHdo
bw0KPiA+ID4gPiA+ID4gPiA+ID4gPiBxdWV1ZXMgdGhlIHdvcmsgbmVlZCB0byBrbm93DQo+ID4g
PiA+ID4gPiA+ID4gPiA+IHRoYXQgdGhlIG9wZXJhdGlvbiBhY3R1YWxseSBmYWlsZWQuIFNvIHdl
IGNhbg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBhZGQgYSBmbGFnIHRvIGluZGljYXRlIHRoYXQNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gZ2FkZ2V0IGlzIGRlYWQgYW5kIHRoZSBjYWxsZXIgb2YgZHdjM19z
ZXRfbW9kZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBjYW4gY2hlY2sgdGhlIGZsYWcgdG8gc2VlIGlm
DQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZSBvcGVyYXRpb24gaXMgc3VjY2Vzc2Z1bCBvciBub3Qu
DQo+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBPciBhbSBJIG1pc3Vu
ZGVyc3RhbmRpbmcgeW91ciBjb21tZW50ID8NCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IE5vdCBqdXN0IGluIF9fZHdjM19zZXRfbW9k
ZSgpLiBJIG1lYW4gYW55IHRpbWUgZHdjM19jb3JlX3NvZnRfcmVzZXQNCj4gPiA+ID4gPiA+ID4g
PiA+IGZhaWxzLCB0aGVuIHdlIHNldCB0aGlzIGZsYWcuIFNvIHRoYXQgaXQgY2FuIHByZXZlbnQg
dGhlIHVzZXIgY2FsbGluZw0KPiA+ID4gPiA+ID4gPiA+ID4gYW55IGdhZGdldCBvcHMgY2F1c2lu
ZyBtb3JlIGNyYXNoZXMvaW52YWxpZCBiZWhhdmlvci4gVGhlDQo+ID4gPiA+ID4gPiA+ID4gPiBk
d2MtPnNvZnRjb25uZWN0IGlzIGFscmVhZHkgd3Jvbmcgb24gcHVsbHVwKCkgb24gZmFpbHVyZS4N
Cj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gU28gdGhhdCB3ZSBjYW4gaGF2
ZSBhIGNoZWNrIGluIGRpZmZlcmVudCBnYWRnZXQgb3BzLiBGb3IgcHVsbHVwKCk6DQo+ID4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVs
bHVwKCkgew0KPiA+ID4gPiA+ID4gPiA+ID4gIMKgwqDCoMKgaWYgKGR3Yy0+dWRjX2lzX2RlYWQp
IHsNCj4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRldiwgInJlc2V0
IG1lLiB4X3ggXG4iKTsNCj4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm47
DQo+ID4gPiA+ID4gPiA+ID4gPiAgwqDCoMKgwqB9DQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiA+ICDCoMKgwqDCoGFiYygpOw0KPiA+ID4gPiA+ID4gPiA+ID4gfQ0KPiA+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBQZXJoYXBzIHRoZSBlZmZvcnQgaXMgcHJv
YmFibHkgdGhlIHNhbWUgaWYgd2UNCj4gPiA+ID4gPiA+ID4gPiA+IGVuaGFuY2UgdGhlIFVEQyBj
b3JlIGZvcg0KPiA+ID4gPiA+ID4gPiA+ID4gdGhpcz8gSW4gYW55IGNhc2UsIEknbSBmaW5lIGVp
dGhlciB3YXkuDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcywN
Cj4gPiA+ID4gPiA+ID4gPiA+IFRoaW5oDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
ID4gSGkgVGhpbmgsDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gIMKgwqAgU28g
eW91IGRvbid0IHdhbnQgVURDIHRvIHJldHJ5IHB1bGx1cCBpZiBpdCBmYWlscyB0aGUNCj4gPiA+
ID4gPiA+ID4gPiBmaXJzdCB0aW1lID8gQXMgcGVyDQo+ID4gPiA+ID4gPiA+ID4gcGF0Y2gtMiBv
ZiB0aGlzIHNlcmllcywgSSB3YXMgdHJ5aW5nIHRvIHByb3BhZ2F0ZSB0aGUNCj4gPiA+ID4gPiA+
ID4gPiBFSVRNRURPVVQgdG8gVURDIHNvDQo+ID4gPiA+ID4gPiA+ID4gdGhhdCB0aGUgY2FsbGVy
IChtb3N0IHByb2JhYmx5IGNvbmZpZ2ZzKSBjYW4gdGFrZQ0KPiA+ID4gPiA+ID4gPiA+IGFwcHJv
cHJpYXRlIGFjdGlvbiBhcyB0bw0KPiA+ID4gPiA+ID4gPiA+IHdoZXRoZXIgaXQgbXVzdCByZXRy
eSBwdWxsdXAgb3Igbm90Lg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gTm93IEknbSBjb25mdXNlZC4gSWYgdGhlIHNvZnQtcmVzZXQgdGltZXMgb3V0LCB0
aGF0IG1lYW5zIHRoYXQgdGhlDQo+ID4gPiA+ID4gPiA+IHNvZnQtcmVzZXQgKHNlbGYtY2xlYXJp
bmcpIGJpdCBpc24ndCBjbGVhcmVkLiBIb3cgY2FuIHdlIHJldHJ5IGlmIGl0J3MNCj4gPiA+ID4g
PiA+ID4gc3R1Y2sgaW4gdGhpcyBzdGF0ZT8gTXkgaW1wcmVzc2lvbiBpcyB0aGF0IHNvZnQtcmVz
ZXQgd291bGQNCj4gPiA+ID4gPiA+ID4gbm90IGNvbXBsZXRlDQo+ID4gPiA+ID4gPiA+IGF0IGFs
bC4gSXMgdGhhdCBub3QgdGhlIGNhc2UgZm9yIHlvdSwgb3IgaXQncyBzaW1wbHkgYmVjYXVzZSB3
ZSBuZWVkIGENCj4gPiA+ID4gPiA+ID4gbG9uZ2VyIHNvZnQtcmVzZXQgdGltZW91dD8NCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gPiA+ID4gVGhpbmgNCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSGkgVGhpbmgsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ICDCoMKgIFNvcnJ5IGZvciBub3QgYmVpbmcgY2xlYXIuIFRoZSBpbnRlbnRpb24gb2YgcGF0
Y2gtMSB3YXMgdG8NCj4gPiA+ID4gPiA+IGVuc3VyZSB3ZSBkb24ndA0KPiA+ID4gPiA+ID4gc3Rh
cnQgdGhlIGNvbnRyb2xsZXIgaWYgcmVzZXQgdGltZXMgb3V0IGFuZCBwYXRjaC0yIHdhcyB0bw0K
PiA+ID4gPiA+ID4gZW5zdXJlIHRoYXQgVURDDQo+ID4gPiA+ID4gPiBpcyBpbiBzeW5jIHdpdGgg
Y29udHJvbGxlciBieSB1bmRlcnN0YW5kaW5nIHRoYXQgZ2FkZ2V0X2Nvbm5lY3QNCj4gPiA+ID4g
PiA+IGhhcyBmYWlsZWQNCj4gPiA+ID4gPiA+IGFuZCBuZWNlc3NhcnkgY2xlYW51cCBoYXMgdG8g
YmUgZG9uZSBpbiBnYWRnZXRfYmluZF9kcml2ZXIuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhh
dCBzaG91bGQgc3RpbGwgYmUgdGhlcmUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IEJ1dCB1c3VhbGx5IHNpbmNlIHRoZSBVRENfc3RvcmUgaXMgdGhlIG9uZSB0aGF0IGlz
IGNhdXNpbmcgcHVsbHVwIHRvIGJlDQo+ID4gPiA+ID4gPiBjYWxsZWQsIHRoZSBlcnJvciB2YWx1
ZSBpcyBwcm9wYWdhdGVkIGJhY2sgdG8gVURDX3N0b3JlLiBJZiBpdCBzZWVzIGENCj4gPiA+ID4g
PiA+IGZhaWx1cmUsIGl0IGRvZXMgYSByZXRyeSB0byBwdWxsdXAuDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IEkgZGlkbid0IGNoZWNrwqAgd2hldGhlciBzdWJzZXF1ZW50IHJldHJpZXMgYnkg
VURDIHRvIHB1bGx1cCBhcmUgaGVscGluZw0KPiA+ID4gPiA+ID4gY2xlYXIgdGhlIHJlc2V0IGJp
dCBvciBub3QuIEJ1dCBJIHRob3VnaHQgcmV0cnlpbmcgcHVsbHVwIHdvbid0DQo+ID4gPiA+ID4g
PiBiZSBvZiBhbnkNCj4gPiA+ID4gPiA+IGhhcm0uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSXQn
cyBmaW5lIHRvIHJldHJ5LiBJJ20gdGhpbmtpbmcgdGhhdCB0aGUgY29udHJvbGxlciBpcyBpbiBh
IGJhZCBzdGF0ZQ0KPiA+ID4gPiA+IGF0IHRoaXMgcG9pbnQgdGhhdCB3ZSBjYW4ndCByZWNvdmVy
IChob3BlZnVsbHkgdGhhdCdzIG5vdCB0aGUgY2FzZSkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IEkgbm93IGdldCB0aGF0IG15IHBhdGNoZXMgYXJlIGluY29tcGxldGUg
dy5yLnQgaGFuZGxpbmcgdGhlIHRpbWVvdXQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElJ
UkMgb25lIG9mIHRoZSBmb2xsb3dpbmcgaXMgd2hhdCB5b3UgYXJlIHN1Z2dlc3Rpbmcgd2UgbmVl
ZCB0byBkbzoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT3B0aW9uLTE6DQo+ID4gPiA+ID4g
PiBTZXQgYSBmbGFnIHdoZW4gcmVzZXQgdGltZXMgb3V0IGFuZCBjbGVhciBpdCB1cG9uIGNvcmVf
ZXhpdCAvDQo+ID4gPiA+ID4gPiBjb3JlX2luaXQuIElmDQo+ID4gPiA+ID4gPiB0aGUgZmxhZyBp
cyBzZXQsIGJsb2NrIGNhbGxzIHRvIGFsbCB0aGUgZ2FkZ2V0X29wcyBpbiBkd2MzLg0KPiA+ID4g
PiA+ID4gQmFzaWNhbGx5IGV2ZW4NCj4gPiA+ID4gPiA+IGlmIHJldHJ5IGhhcHBlbnMgZnJvbSBj
b25maWdmcy9VREMsIHdlIGJhaWwgb3V0IGluIHB1bGx1cC91ZGNfc3RhcnQgZXZlbg0KPiA+ID4g
PiA+ID4gd2l0aG91dCB0cnlpbmcgdGhlIHJlcXVlc3RlZCBnYWRnZXQgb3BlcmF0aW9uLg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPcHRpb24tMjoNCj4gPiA+ID4gPiA+IElmIGdhZGdldF9j
b25uZWN0IGZhaWxzIHdpdGggLUVUSU1FRE9VVCBpbiBVREMsIGhhbmRsZSB0aGUgZmFpbHVyZSBh
bmQNCj4gPiA+ID4gPiA+IGltcGxlbWVudCB0aGUgc2FtZSBmbGFnIGluIFVEQyBhbmQgZG9uJ3Qg
ZXZlbiBjYWxsIGFueSBnYWRnZXRfb3BzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4g
PiA+IEhpIFRoaW5oLA0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0K
PiA+ID4gPiANCj4gPiA+ID4gPiBJJ20gdGhpbmtpbmcgb2Ygb3B0aW9uLTEuIEZvciBvcHRpb24t
Miwgd2UgY2FuJ3QgY29udHJvbCBpZiB0aGUNCj4gPiA+ID4gPiBnYWRnZXRfb3BzIHdpbGwgYmUg
Y2FsbGVkLiBXZSBvbmx5IGhhdmUgY29udHJvbCBob3cgd2Ugd2lsbCByZXNwb25kIGluDQo+ID4g
PiA+ID4gY2FzZSB0aGV5IGdldCBjYWxsZWQgYWdhaW4uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
QnV0IG5vdyBJJ20gdGhpbmtpbmcgYWdhaW4sIEkgdGhpbmsgaXQgbWF5IGJlIG9rIHdpdGhvdXQg
YWRkaW5nIHRoZQ0KPiA+ID4gPiA+IGZsYWcuIFRoZSBVREMgY29yZSBhbmQgZ2FkZ2V0IGRyaXZl
ciB3b24ndCBkbyBhbnl0aGluZyBlbHNlIGJlZm9yZQ0KPiA+ID4gPiA+IHB1bGx1cCgxKSBpcyBz
dWNjZXNzZnVsLiBDYWxsaW5nIG90aGVyIGdhZGdldF9vcHMgc2hvdWxkIGJlIGhhcm1sZXNzDQo+
ID4gPiA+ID4gKGllLiBpdCB3b24ndCBjcmFzaC9icmVhayB0aGUgc3lzdGVtKT8NCj4gPiA+ID4g
PiANCj4gPiA+ID4gSSBjYW4gZ2l2ZSB0aGlzIGEgdHJ5IGluIGxvbmcgcnVuIHRlc3RpbmcgKEZv
ciA3LTE0IGRheXMpIGFuZCBzZWUgaWYNCj4gPiA+ID4gYW55dGhpbmcgZWxzZSBpcyBicmVha2lu
Zy4NCj4gPiA+ID4gDQo+ID4gPiA+IE1vc3QgcHJvYmFibHkgd2UgZG8gYSBjb21wb3NpdGlvbiBz
d2l0Y2ggLyBQSVBPIGluIGJldHdlZW4gd2hpY2ggY2FuDQo+ID4gPiA+IGNhbGwgdXNiX2dhZGdl
dF91bnJlZ2lzdGVyX2RyaXZlciB3aGljaCBtaWdodCBpbnZva2UgYSBwdWxsdXAoMCkNCj4gPiA+
ID4gZm9sbG93ZWQgYnkgdWRjX3N0b3AoKSBhbmQgbGlrZSB5b3UgbWVudGlvbmVkIG11c3Qgbm90
IGJlIGEgcHJvYmxlbS4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gU29ycnkgZm9yIHRoZSBub2lzZSwg
YnV0IEkgdGhpbmsgaXQgbWF5IGJlIG9rIHdpdGhvdXQgbWFya2luZyB0aGUNCj4gPiA+ID4gPiBj
b250cm9sbGVyIGRlYWQuIEkgd29uZGVyIGlmIHdlIGNhbiBjb25maXJtIG15IHN1c3BpY3Rpb24g
b24gcmV0cnk/IEkNCj4gPiA+ID4gPiBiZWxpZXZlIHRoaXMgaXMgbm90IGVhc3kgdG8gcmVwcm9k
dWNlIG9uIHlvdXIgc2V0dXA/IElmIG5vdCwgSSB0aGluayB3ZQ0KPiA+ID4gPiA+IGNhbiB0YWtl
IHlvdXIgY2hhbmdlIGFzIGlzLg0KPiA+ID4gDQo+ID4gPiBIaSBUaGluaCwNCj4gPiA+IA0KPiA+
ID4gICAgSSBnb3QgdGhpcyBwYXRjaCB0ZXN0ZWQgb24gdHdvIGRpZmYgR2VuLTIgdGFyZ2V0cyBm
b3IgYXJvdW5kIDEwIGRheXMgYW5kDQo+ID4gPiBubyBpc3N1ZXMgd2VyZSBzZWVuLiAoTm8gU01N
VSBmYXVsdCBzZWVuIG9uIGEgMTAgZGF5IHJ1bikuIExldCBtZSBrbm93IG9mDQo+ID4gPiBhbnkg
b3RoZXIgY29uY2VybnMgdGhhdCBtaWdodCBjb21lIHVwIHdpdGggdGhpcyBwYXRjaC4gRWxzZSBJ
IGNhbiByZWJhc2UgaXQNCj4gPiA+IHRvIGdldCBtZXJnZWQuDQo+ID4gPiANCj4gPiA+IFJlZ2Fy
ZHMsDQo+ID4gPiBLcmlzaG5hLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIHRlc3RzLiBTbyB5
b3Ugd2VyZSBhYmxlIHRvIG9ic2VydmUgdGhlIGZhaWx1cmUgYW5kIGFibGUNCj4gPiB0byByZWNv
dmVyIGZyb20gaXQgd2l0aG91dCBTTU1VIGZhdWx0IHJpZ2h0Pw0KPiA+IA0KPiBIaSBUaGluaCwN
Cj4gDQo+ICAgSWRlYWxseSBpZiB0aGUgaXNzdWUgZGlkbid0IGNvbWUgdXAgZm9yIG1vcmUgdGhh
biBhIHdlZWsgc3RyYWlnaHQsIEkNCj4gYmVsaWV2ZSB0aGF0IHdlIGFyZSBhYmxlIHRvIHJlY292
ZXIgZnJvbSB0aGUgaXNzdWUuDQo+IA0KPiBSZWdhcmRzLA0KPiBLcmlzaG5hLA0KDQpIaSBLcmlz
aG5hLA0KDQpJIHdhbnRlZCB0byBjb25maXJtIHdoZXRoZXIgdGhlIGNvbnRyb2xsZXIgaXMgZGVh
ZCBhbmQgd2hldGhlciBhbnkNCmF0dGVtcHQgdG8gYWNjZXNzIHRoZSBjb250cm9sbGVyIGF0IHRo
aXMgcG9pbnQgY2FuIGJlIGZhdGFsIHRvIHRoZQ0Kc3lzdGVtIChzdWNoIGFzIFNNTVUgZmF1bHQp
LiBJIGJlbGlldmUgeW91ciBwYXRjaGVzIHByZXZlbnRzIFNNTVUgZmF1bHQNCm9uIGZpcnN0IGZh
aWx1cmUuIEknbSBub3Qgc3VyZSB3aGF0IHdpbGwgaGFwcGVuIGFmdGVyIGlmIHdlIGF0dGVtcHQg
YQ0KcmV0cnkuDQoNClJlZ2FyZGxlc3MsIHlvdXIgY2hhbmdlcyBhcmUgZ29vZCBmb3Igbm93LiBJ
ZiB3ZSBuZWVkIHRvIG1ha2UgZnVydGhlcg0KZW5oYW5jZW1lbnQgaW4gdGhlIGZ1dHVyZSwgd2Un
bGwgZG8gdGhhdCBsYXRlci4NCg0KTWFueSB0aGFua3MgZm9yIHRoZSB0ZXN0cywNClRoaW5o
