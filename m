Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E276F4CED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjEBWg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBWgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:36:54 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798F1FFB;
        Tue,  2 May 2023 15:36:50 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JWmKP022409;
        Tue, 2 May 2023 15:36:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=JEwsGKoWC+iTiJM+coemKOsr4O13KiEvBUVrBetLdzI=;
 b=wFxQVP2eBosVp9xYLCY872kAKMpgemuEcjNAno4sRWLAyvFHbnOaVwuAhB9xgZGtSg1s
 gSPncyrrDPzncGr8LTnif+dlPiS5VcuNddSBFzhIZY3S1ckFPub+RicvFVbqxabwlxIy
 Z4JA1UNY/bZbrQ40tL3uDEz4ee5bNBCyMN7O/r3hQsE2hYDxrvE14eCMADPhX8lIkbOd
 e7/lE1Zga8s2namCNHrkTSl2Zc3KDjP5FHFHrBFAedcXtViQ3HI2+38kmgkDpah0XnwT
 rA4rJjo8CcIzSzFow+lgZSmpgQUaNUQnCdDScYZuX1JReBH7z49dkkBvEsHvIJNRxPoB YQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3q91vj72eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 15:36:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683066997; bh=JEwsGKoWC+iTiJM+coemKOsr4O13KiEvBUVrBetLdzI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LbIN9Vjas4m4E91EgRbal6eb7eFKBLiP9pM69smNlNSBy5AhTm+mP5DGaFRanhxjw
         99DKxH0Ka889SMAgPXwmQExaN8ZFJNulmIkgNAef9hUBsV5SfKConvdg7iBdj/xf0H
         s1gMxZLZwC099M1fZlXBTkH9u+6//RvC2h8Npa/teL2HYkWntZpsQFrBfphRvGsSxC
         2KAZLl0y0XulrVO/bW+9cPHU+UzqqFuhPVlAHC90h2vDK7gAYD/fASmg1Yal4ywlo8
         2mT4g+IvDpJzD2wEnk33CcSYf3HdpgoL5KR1WMlY2J/dRtS3fe7PC+e3llWzJgXs9r
         Pg6Z0+K2u5pTw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3431140523;
        Tue,  2 May 2023 22:36:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 28035A0062;
        Tue,  2 May 2023 22:36:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=V7QOVERB;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B875C40605;
        Tue,  2 May 2023 22:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRhYnbGdiDDBEdyFc27DRR8EkAx8BazokRPA7gGJbDaR75kN0N0QccUvkl1R79KW0E/NdsPJd8RjhRIFtbDB3xqLRYvFV3cIPASsvRhealV3q6H8zOwLvuUNwgenGJ8Paz2T1PKXPMFrfXkp85TMAEfzaI8CRpGh6dG4ISd1mh3mERUe44Lu/WGApCpdGpWvhcmudLk8lZ3wjA9qlW2KXzXcpJ0NTnyBj05t8tZLFcdil2njc2QRj/+rK86Vmr6AasSUK42hLwKmx4DjTJQTB4Bu5ZwXrsAmwF2IZsULrZ90inxwxt5hx1FFfi1AcsD1K6QVhB3R8rcAQo3NR9jXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEwsGKoWC+iTiJM+coemKOsr4O13KiEvBUVrBetLdzI=;
 b=G/7Sf1G5Phc7X6bVdC5gCi2nVbvkqTJqIYH6e0SWCWeaiSwABwJVg6TXgVAdz3wZ5Fs7THoQKA/DuApfi6IVV7y2fhOFNvUmnnNPxBuOVrioX9ryIS6t09VOhX/brqHHRz0ZNL3VxJCOL9K8Frrl8VdFoiXcJ3V39W9RWsiA0BlxcnjC+8E0Pnmw/TxlmKvI4Ua+oVJF3paidYDxeVgdIiTKCKxji4tySEZzS3jGlmjeRWB3+D+vfNfDehSMStAxghsALT6zB24MVoflEpdTbgm/zfLH53qMrKl7/i7KU0+g6hrh9woP8PFnfztVKD1WutrHfeO1SerfJHFstVX2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEwsGKoWC+iTiJM+coemKOsr4O13KiEvBUVrBetLdzI=;
 b=V7QOVERBHZSVjXQzmDIRffH25IQZXWtH32wdDrm4GY5g+mz+OItrUoROgfO4kzehRpmxdQEhZDJDyy0BS66V7aEnVayjvL7mG7aNncCj6rxiun/sf4vck/dzjkDiFOGpsbxsMC17ntVlVMMglZnuXHHGgcxdWYHe95SHt08GUH0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 22:36:32 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 22:36:31 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's
 global register start address
Thread-Topic: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's
 global register start address
Thread-Index: AQHZfLOqlY1W2Ii4CkekbWMOKFVBP69Hk6cA
Date:   Tue, 2 May 2023 22:36:31 +0000
Message-ID: <20230502223626.uyld3tv7d7fnbt7h@synopsys.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
In-Reply-To: <20230502050452.27276-1-stanley_chang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW5PR12MB5622:EE_
x-ms-office365-filtering-correlation-id: cf5b8663-a204-4291-6996-08db4b5dad76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ZI2ki4fGMDYHUOJZRNldjnBhO8MMvrAdlvsh1cY3L5kQ3enpGaMCWb1lqgWgtsjb2QIc9asK6mY5rlQYFZZY2+f9sfn5UPV59Txb46FZp1cAsVAUgWHdJKwLILfmqStGc452RBpRR2ciQnxuAuLN8wX2awMOcUcth9MkEgovTiNd2AgPugq6Dr1o7xQBaRH0M+oW33mBK7V6nUy3qCAY3FuVjC+ox5Y70e8byf5cuBQ/FQV2Co2xNE+A7oUSCGZ4l9IoKfLL0JaFtuw8u511zBZF7/fQ4xEj6sJgrxdxwhtQmVdPUhgqUvwx0CvAx+d7Hpb4oOc6Yc6+SX1ed6/DcqWe6lBv5lVuxD9XKUkYTa39SHkKdlggDCPX33Z74mD6GlMAlBFJ0+HQdqP6hYolWL34+hcAPVMpbHuFUNF/YVwB2+BgdqTitTvGq4i32unYJnCZDhxVNQUeOmUJSerVw2C/qP2hob4xwNt+Csk7YVe8sbDGiIBrjXkXTYQPuRnrqpvicT8ozBZwWbJMHC2tqbHYmpRmife8ESObLavfVCm41AQhtEopQvMC+HRQzbdg3DEYDLFyGWKFnYZ8oLmGVza19wXw7b0NL4/SKkicmLzmXUc+UJMAK5A1REdWL3Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(2906002)(5660300002)(122000001)(186003)(54906003)(66476007)(8676002)(8936002)(1076003)(26005)(6512007)(6506007)(83380400001)(478600001)(76116006)(86362001)(2616005)(71200400001)(38100700002)(36756003)(6486002)(66556008)(6916009)(316002)(66946007)(66446008)(41300700001)(38070700005)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUJZc05vNEM0UDduS1JNUTJOQzJlaTE3TVNiQzNyd3lrUDdIWEs5VGk5SkQ5?=
 =?utf-8?B?aFFNZEJXOFR2WE1FYWNUa2JUN3hqME5mM2t2TkJqNWp6R21lR0dKWlZjQXpN?=
 =?utf-8?B?c2pCeFlaYUZIejB1eWF2cERCdjR1aUFGVlhJS242UktDVGdSbHNYNnR5WWUr?=
 =?utf-8?B?UUJTZ3ZXdktKNWFoK1k5UFZ2cnZwTm1DNGtyWmlDV0JNTTl1dUI1UkVWdytU?=
 =?utf-8?B?dFJQSSttSlBhUUVyQy8rc3ZteU9STkdqZHlkVTdOU2JqU0ZvWmpDelVpZnEv?=
 =?utf-8?B?NlhSZGMzOHdnekN5NWF1TVdCdjM0ZEtreVdramJvT0hUeFd3MkRvZU1MV05p?=
 =?utf-8?B?Zm01eEg3emFCamt6cHNMN3dzR3VLV3BNbXN3aUV5YVlkeVVxVUE4VndoSVJN?=
 =?utf-8?B?T1haa3FkU2NyeTN1aUZFdFlLSzNNTnhEZzhhTGltcUxCZlA4K0U4d1g1dktM?=
 =?utf-8?B?Q3hSN3lYVDhsSS9Kd2d2RXNtd1lvSjhjRGRkL1FKMXUvdjdydWxWeWRZcGs3?=
 =?utf-8?B?T01EZ2pkcWJkMHkzL1lXcDNrdGJZMlIwbUV6aGl1UXFzcVRzTkp6NHhsekpv?=
 =?utf-8?B?MC9VZitiNVMzWDk0ZHJBWXRodHZIZkhtNEJzckJzaVUwNmJjaGxFaVVndjdI?=
 =?utf-8?B?RzJTRXhNS3ZDLzdoRTN1WGZJM0RwRnEwOVNZQzZ3SzRQekp2Z1dzQ2JkRmxo?=
 =?utf-8?B?cFpOZmtDZG0xSlEzdmh0ZU5EOVgzSytXSXpTUXBLWFNqZ0pXUmVORDRyeGVI?=
 =?utf-8?B?SVpQOTRvMTByeGlpL1cvRmozbU9Oc1VFSS80NWl3a29LQlg4K1I3a3A1N1hD?=
 =?utf-8?B?MnBEYTNKdmNNZjM4STdHQ1dQdGxXL0JEM1JRalFOT0doZEJqVW8rc3pJS3VX?=
 =?utf-8?B?YUhBREE5Zk50WGhsd0QvazlxY2oxQndYU0ZSRVN3c21tQWtMSGVPNUUvS0c1?=
 =?utf-8?B?cHp1UG9VcEFvUVVrYldmbTN1OCt6WEhuOU9ocEJLL3VsUkdDSHZCZTRBQkdI?=
 =?utf-8?B?WlRhR2dSVUptamVDNENjN0R6RnhRWGsrZVFsa2U5dGJCSklPeGJXSmVMRjY3?=
 =?utf-8?B?azNvOC94ajgzVlZsaHhQdllkOTEvM01WSnF2U2ZFblB5OHlQY1lDWGZ5a0tP?=
 =?utf-8?B?d0RENjVUREgrOGRPYUFhbkhSR0NvNlZUNzJsWExYVTRqaFZKM3pxeWFDVFpp?=
 =?utf-8?B?UU9CUVlLVlNPQUJPUGFZYzVpNGNEelVIaG01TUozVEFHdWU1WXNueENnQWZC?=
 =?utf-8?B?NWZGdlZqanlQK1JMZnNYOFhOcXE0bkRaUVI2aEFNaE9ZcDZaZlBFMUxhUXQ2?=
 =?utf-8?B?SzNPNWFKbDg5dFN2TEFVYTBnR2xPUU8wZU1EOStSVHdZQzdxQm1BUTY5VERu?=
 =?utf-8?B?QTNBMnZOcDhScm5jMnhMOXVLN3ppNkpZUXhNOEdZUHozSU11WklmR3ByVEFC?=
 =?utf-8?B?eE9RQjF2Z2ZuV3lrQ0dTbEFTMFk0MW1vMGtJRUx6cDB2MUZxUnAzazJzOVAx?=
 =?utf-8?B?UGZjcEZxbk94d09pN3g2YjY5MEtwWWRyN3VtdmY5YnNLQ1FLS1FhWjUxYmlF?=
 =?utf-8?B?anUvR3I3cSt0WnZRb1pMU3A4d3lqbWR3ZGNiZXUvYkF3RCthNEt3a3lLV2Qw?=
 =?utf-8?B?aTk4Z2hQRmxmaURReUdZR1daaVk2R2FzTTM0VktBb2hLdzhaSCtxK2dCcTZ3?=
 =?utf-8?B?NytiRkNDc2F4b216M0RUVDNRL3hWejhmL0kxUTQ0YU0wRHRtYTZBbzVrdXlR?=
 =?utf-8?B?eFNFYjF0R205VnRqRUkrODN6ZmVjd0pNdms0dURydVg3alYxdGYrVjdwaWow?=
 =?utf-8?B?VmI3RFVhUEgrZTIzTFNoRTBnZURqb3lQMDlMOFA0M1NjRW9oOWpkR0tQcEtK?=
 =?utf-8?B?RVA4VE5IR2NSNGh6ZU8zY3FDaGV6d2FhSVg5Z2pOQk54V1dDZjgyeHNLalBz?=
 =?utf-8?B?RVZIYWpGUE1tV2dFc2I1VzJYQjQvUVFHc3FURklvWWNxa0FOOUNjQW80VXVn?=
 =?utf-8?B?d0N0VFhQSWdCNzU5bi9RcXUvY2VjRWVVK3ZrOWZBd1MyMWUrL0pZbjA5bjVn?=
 =?utf-8?B?bjFJWnNEanJiVVhOVDdWSDI2aHNITzlBZGRtcVk0aW5NNVJzd3o4b2ZnV0Q3?=
 =?utf-8?Q?XN3C3LdTpWCd0OVptjQNcUoIX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9681BCD3C1E0BA4DBFF149B455946F72@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UVd5RlVUcHd1L2x3MFFzenFiaXRBTFd6anNZZ3plc1RCcUtTS2o4MWVVd09i?=
 =?utf-8?B?Wkx4azRrRTdVTDhqbWlQeDlLNk1pYTFhazJPem9xMDlEQUo3V0VIQ1U2QnBN?=
 =?utf-8?B?SVl1QXpCWHpaMG5yeVBKeEVRc1BVTlpxMmppNXNiTndpbzF6blU5NzlKYUFR?=
 =?utf-8?B?RHlJMW9Yci9qSTJORTVQYVA1cjErSkJIL0xJa2Z1SkE2WUltcndENUpJNWlw?=
 =?utf-8?B?YnIyd04xZEN1UlFqelVWTDIvNVNGbllUSWc0RDBtQ3JHSjZPS2FZWWIxaG0z?=
 =?utf-8?B?OC91OXdOSVVTdVQzRkxqZS9hWHpvQTdlMExvQkNuNFI4cTNicXc5VnNSOFIx?=
 =?utf-8?B?dUZHQy85QTVCa0psSE9mNTVhQy9tYTNKMGNEbHlzby9SR094RDFTdHR4aUlk?=
 =?utf-8?B?S2xtckt2Y0FzNGF1cUw0ZlRDTzFrMTFNMkRpRS9qc2pBSUpYUjdhTGswa0ZX?=
 =?utf-8?B?NlhOeXlRZjNkeGY3TVQrNHBreEE2YzhRV0VtRnBmU25jR2NtQ0pOb0JZdjJ5?=
 =?utf-8?B?TWcxVTJ5VmZHYUxHaVplaExTRVN6WEdKR0xqc015L1E0RUhKekJITW5VNFBt?=
 =?utf-8?B?SWNHM1RMK3F0cVBaSzN0YnIrZW9ZSjZtcTJGWU9NdzlPU21DU2IrVGVWME5F?=
 =?utf-8?B?MFcyVHZHMXJrSU5Qb3RoaDJKNU1tN3RtbTR2aVNnZDZvSHU2L1N5WW83SFY1?=
 =?utf-8?B?d1dzMTlmS1Y1aGc5ZC9iVDhJWU8yOUNXRFVZcEVid3pBRVh2dU8zN1NpU1RG?=
 =?utf-8?B?VW4yTVFPQlNsc2NPNmtHQklHendHTERxb0czcjZBeGFXS2ZLd01Qa3JwZ0J4?=
 =?utf-8?B?SHpEVjhPaDFGeDNsTGFtUzlIaXN4MkN2MGZRZEpLZllBSy9GYnN3dGtMMGVz?=
 =?utf-8?B?UGtyT0xwQng3eGVkanlnZVZ6Nmw0b0tmR3dlR0NCcER2QjhUWWlCTVpUZEdy?=
 =?utf-8?B?cW42Z2xkTmtqRHNBalFueGdRN0VOYkVGbEk5RGxCWGpWaURIRW02QjNJSUdM?=
 =?utf-8?B?bDJES05DVExER0ZVS3Awc0kvVWlpZEJBZEs0ei9MWDJoQTRKNjNiODhzc1R4?=
 =?utf-8?B?Y0ZFYldJcDN3L0VRbWZjQzRKQUFoak1UbUpIT1FMeU1ZaVNONzhiOFpWZVZP?=
 =?utf-8?B?R0I0QXd1d0gwWWNpVVZkMG16cllEL2NEalM3MGFmZk1YYVJwN0h2NzYvY2tv?=
 =?utf-8?B?K0VJM2JHd0xWb0RGeVRjc2wraWd3bWJUNThLK05FK05ObGJ6SGtKQXpnK1FX?=
 =?utf-8?Q?6BDe51coZHemONu?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5b8663-a204-4291-6996-08db4b5dad76
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 22:36:31.7014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1IZnNkEjWK4tPJ6YVmzKm1J/ghjA+Bd6MNaEPoa3hD+xZyO2pKhGPLzdZQcGGlAcjB3xBBqk7RVqn0sBz6uVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
X-Proofpoint-GUID: 911ECETOFPr2ZVgH-ZSh5a0Se3SME2HF
X-Proofpoint-ORIG-GUID: 911ECETOFPr2ZVgH-ZSh5a0Se3SME2HF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMDIsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+IFRoZSBSVEsgREhD
IFNvQ3Mgd2VyZSBkZXNpZ25lZCwgdGhlIGdsb2JhbCByZWdpc3RlciBhZGRyZXNzIG9mZnNldCBh
dA0KPiAweDgxMDAuIFRoZSBkZWZhdWx0IGFkZHJlc3Mgb2Zmc2V0IGlzIGNvbnN0YW50IGF0IERX
QzNfR0xPQkFMU19SRUdTX1NUQVJUDQo+ICgweGMxMDApLiBUaGVyZWZvcmUsIGFkZCB0aGUgY29t
cGF0aWJsZSBuYW1lIG9mIGRldmljZS10cmVlIHRvIHNwZWNpZnkNCj4gdGhlIFNvQyBjdXN0b20n
cyBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQgYWRkcmVzcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0
YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+DQo+IC0tLQ0KPiAgdjMgdG8g
djQgY2hhbmdlOg0KPiBVc2UgdGhlIGNvbXBhdGlibGUgbmFtZSB0byBzcGVjaWZ5IHRoZSBnbG9i
YWwgcmVnaXN0ZXIgYWRkcmVzcyBvZmZzZXQuDQo+IElmIHRoZSBjb21wYXRpYmxlIG5hbWUgaXMg
InNucHMsZHdjMy1ydGstc29jIiwgdGhlbiB0aGUgb2Zmc2V0IHVzZSAweDgxMDAuDQo+IE90aGVy
d2lzZSwgdGhlIG9mZnNldCBpcyBkZWZhdWx0IHZhbHVlIDB4YzEwMC4NCj4gDQo+ICB2MiB0byB2
MyBjaGFuZ2U6DQo+IDEuICBGaXggdGhlIGR0c2NoZW1hIHZhbGlkYXRpb24gZXJyb3IuDQo+IA0K
PiAgdjEgdG8gdjIgY2hhbmdlOg0KPiAxLiBDaGFuZ2UgdGhlIG5hbWUgb2YgdGhlIHByb3BlcnR5
ICJzbnBzLGdsb2JhbC1yZWdzLXN0YXJ0aW5nLW9mZnNldCIuDQo+IDIuIEFkanVzdCB0aGUgZm9y
bWF0IG9mIGNvbW1lbnQuDQo+IDMuIEFkZCBpbml0aWFsIHZhbHVlIG9mIHRoZSBnbG9iYWxfcmVn
c19zdGFydGluZ19vZmZzZXQNCj4gNC4gUmVtb3ZlIHRoZSBsb2cgb2YgZGV2X2luZm8uDQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxOCArKysrKysrKysrKysrKystLS0NCj4g
IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDUgKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MjAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDBi
ZWFhYjkzMmU3ZC4uNGY2OWIyNmQ3ZGFiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMjMsNiArMjMs
NyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZG1h
LW1hcHBpbmcuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L29mX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L29mX2dyYXBoLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvYWNwaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvY29uc3VtZXIuaD4N
Cj4gQEAgLTE3OTMsMTIgKzE3OTQsMTcgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJZHdjLT54aGNpX3Jlc291cmNlc1swXS5mbGFncyA9
IHJlcy0+ZmxhZ3M7DQo+ICAJZHdjLT54aGNpX3Jlc291cmNlc1swXS5uYW1lID0gcmVzLT5uYW1l
Ow0KPiAgDQo+ICsJZHdjLT5nbG9iYWxfcmVnc19zdGFydGluZ19vZmZzZXQgPSAodTMyKSh1aW50
cHRyX3QpDQo+ICsJCSAgICBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gKwlpZiAo
IWR3Yy0+Z2xvYmFsX3JlZ3Nfc3RhcnRpbmdfb2Zmc2V0KQ0KPiArCQlkd2MtPmdsb2JhbF9yZWdz
X3N0YXJ0aW5nX29mZnNldCA9IERXQzNfR0xPQkFMU19SRUdTX1NUQVJUOw0KPiArDQo+ICAJLyoN
Cj4gIAkgKiBSZXF1ZXN0IG1lbW9yeSByZWdpb24gYnV0IGV4Y2x1ZGUgeEhDSSByZWdzLA0KPiAg
CSAqIHNpbmNlIGl0IHdpbGwgYmUgcmVxdWVzdGVkIGJ5IHRoZSB4aGNpLXBsYXQgZHJpdmVyLg0K
PiAgCSAqLw0KPiAgCWR3Y19yZXMgPSAqcmVzOw0KPiAtCWR3Y19yZXMuc3RhcnQgKz0gRFdDM19H
TE9CQUxTX1JFR1NfU1RBUlQ7DQo+ICsJZHdjX3Jlcy5zdGFydCArPSBkd2MtPmdsb2JhbF9yZWdz
X3N0YXJ0aW5nX29mZnNldDsNCg0KSSB0aGluayB5b3UncmUgb3ZlcmNvbXBsaWNhdGluZyB0aGlu
Z3MgaGVyZS4NCg0KQ2FuIHdlIGp1c3QgbWF0Y2ggdXNpbmcgY29tcGF0aWJsZSBzdHJpbmcgYXMg
bWVudGlvbmVkIGJlZm9yZT8gSSBiZWxpZXZlDQpJIHN1Z2dlc3RlZCB0byB1c2UgdGhhdCBiZWZv
cmUgYnV0IEkgdGhpbmsgeW91IGhhZCBpc3N1ZSB3ZSBnZXR0aW5nIGl0DQpiZWNhdXNlIGl0J3Mg
ZnJvbSB0aGUgcGFyZW50IGRldmljZT8NCg0KRGlkIHlvdSB0cnkgdGhpcz8NCg0KCWR3Y19yZXMu
c3RhcnQgPSBEV0MzX1JUS19BQkNfR0xPQkFMX09GRlNFVDsNCg0KCWlmIChkZXYtPm9mX25vZGUp
IHsNCgkJc3RydWN0IGRldmljZV9ub2RlICpwYXJlbnQgPSBvZl9nZXRfcGFyZW50KGRldi0+b2Zf
bm9kZSk7DQoNCgkJaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKHBhcmVudCwgInlvdXItY29t
cGF0aWJsZSIpKQ0KCQkJZHdjX3Jlcy5zdGFydCA9IERXQzNfUlRLX0FCQ19HTE9CQUxfT0ZGU0VU
Ow0KDQoJCW9mX25vZGVfcHV0KHBhcmVudCk7DQoJfQ0KDQo+ICANCj4gIAlyZWdzID0gZGV2bV9p
b3JlbWFwX3Jlc291cmNlKGRldiwgJmR3Y19yZXMpOw0KPiAgCWlmIChJU19FUlIocmVncykpDQo+
IEBAIC0yMjI0LDEwICsyMjMwLDE2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBk
d2MzX2Rldl9wbV9vcHMgPSB7DQo+ICAjaWZkZWYgQ09ORklHX09GDQo+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBvZl9kd2MzX21hdGNoW10gPSB7DQo+ICAJew0KPiAtCQkuY29t
cGF0aWJsZSA9ICJzbnBzLGR3YzMiDQo+ICsJCS5jb21wYXRpYmxlID0gInNucHMsZHdjMyIsDQo+
ICsJCS5kYXRhID0gKHZvaWQgKilEV0MzX0dMT0JBTFNfUkVHU19TVEFSVCwNCj4gKwl9LA0KPiAr
CXsNCj4gKwkJLmNvbXBhdGlibGUgPSAic25wcyxkd2MzLXJ0ay1zb2MiLA0KPiArCQkuZGF0YSA9
ICh2b2lkICopRFdDM19HTE9CQUxTX1JFR1NfU1RBUlRfRk9SX1JUSywNCg0KRG9uJ3QgZG8gdGhp
cy4NCg0KPiAgCX0sDQo+ICAJew0KPiAtCQkuY29tcGF0aWJsZSA9ICJzeW5vcHN5cyxkd2MzIg0K
PiArCQkuY29tcGF0aWJsZSA9ICJzeW5vcHN5cyxkd2MzIiwNCj4gKwkJLmRhdGEgPSAodm9pZCAq
KURXQzNfR0xPQkFMU19SRUdTX1NUQVJULA0KPiAgCX0sDQo+ICAJeyB9LA0KPiAgfTsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmgNCj4gaW5kZXggZDU2NDU3YzAyOTk2Li40NjU1N2NmNTJmNGIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+
IEBAIC04NCw2ICs4NCw4IEBADQo+ICAjZGVmaW5lIERXQzNfT1RHX1JFR1NfU1RBUlQJCTB4Y2Mw
MA0KPiAgI2RlZmluZSBEV0MzX09UR19SRUdTX0VORAkJMHhjY2ZmDQo+ICANCj4gKyNkZWZpbmUg
RFdDM19HTE9CQUxTX1JFR1NfU1RBUlRfRk9SX1JUSyAweDgxMDANCj4gKw0KPiAgLyogR2xvYmFs
IFJlZ2lzdGVycyAqLw0KPiAgI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMAkJMHhjMTAwDQo+ICAjZGVm
aW5lIERXQzNfR1NCVVNDRkcxCQkweGMxMDQNCj4gQEAgLTExMTgsNiArMTEyMCw4IEBAIHN0cnVj
dCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAgICogQHdha2V1cF9jb25maWd1cmVkOiBzZXQg
aWYgdGhlIGRldmljZSBpcyBjb25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwLg0KPiAgICogQGlt
b2RfaW50ZXJ2YWw6IHNldCB0aGUgaW50ZXJydXB0IG1vZGVyYXRpb24gaW50ZXJ2YWwgaW4gMjUw
bnMNCj4gICAqCQkJaW5jcmVtZW50cyBvciAwIHRvIGRpc2FibGUuDQo+ICsgKiBAZ2xvYmFsX3Jl
Z3Nfc3RhcnRpbmdfb2Zmc2V0OiBzZXQgdGhlIGR3YzMgZ2xvYmFsIHJlZ2lzdGVyIHN0YXJ0IGFk
ZHJlc3MNCj4gKyAqCSBhbmQgaXQgaXMgZGVmYXVsdCBhdCBEV0MzX0dMT0JBTFNfUkVHU19TVEFS
VCAoMHhjMTAwKS4NCj4gICAqIEBtYXhfY2ZnX2VwczogY3VycmVudCBtYXggbnVtYmVyIG9mIElO
IGVwcyB1c2VkIGFjcm9zcyBhbGwgVVNCIGNvbmZpZ3MuDQo+ICAgKiBAbGFzdF9maWZvX2RlcHRo
OiBsYXN0IGZpZm8gZGVwdGggdXNlZCB0byBkZXRlcm1pbmUgbmV4dCBmaWZvIHJhbSBzdGFydA0K
PiAgICoJCSAgICAgYWRkcmVzcy4NCj4gQEAgLTEzMzQsNiArMTMzOCw3IEBAIHN0cnVjdCBkd2Mz
IHsNCj4gIAl1bnNpZ25lZAkJd2FrZXVwX2NvbmZpZ3VyZWQ6MTsNCj4gIA0KPiAgCXUxNgkJCWlt
b2RfaW50ZXJ2YWw7DQo+ICsJdTMyCQkJZ2xvYmFsX3JlZ3Nfc3RhcnRpbmdfb2Zmc2V0Ow0KPiAg
DQo+ICAJaW50CQkJbWF4X2NmZ19lcHM7DQo+ICAJaW50CQkJbGFzdF9maWZvX2RlcHRoOw0KPiAt
LSANCj4gMi4zNC4xDQo+IA0KDQpQbGVhc2Ugbm90ZSB0aGF0IHRoaXMgaXMgdmVyeSB1bmlxdWUg
dG8gUmVhbHRlaywgSSdtIG5vdCBhd2FyZSBvZiBhbnkNCm90aGVyIHZlbmRvciB0aGF0IHJlY29u
ZmlndXJlZCB0aGUgcmVnaXN0ZXIgb2Zmc2V0IHRoYXQgb3VyIElQDQpzcGVjaWZpZWQuIFNvLCBp
dCBtYWtlcyBtb3JlIHNlbnNlIHRvIG1hdGNoIHVzaW5nIGNvbXBhdGlibGUgc3RyaW5nIHRoYW4N
CmNyZWF0aW5nIGEgc2VwYXJhdGUgcHJvcGVydHkgdGhhdCB5b3UgbWF5IGJlIHRoZSBvbmx5IHVz
ZXIgdGhhdCBuZWVkcw0KaXQuDQoNClRoYW5rcywNClRoaW5o
