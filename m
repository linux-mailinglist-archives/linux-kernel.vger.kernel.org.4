Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD56DA6AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjDGAqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDGAqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:46:49 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C53A6EA1;
        Thu,  6 Apr 2023 17:46:48 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336N3MUR020969;
        Thu, 6 Apr 2023 17:46:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=d3Qa2SmVGgV1eKz9DE9I32OcNteOqNL265gGRDJ3vDM=;
 b=tWDsVrjEGb9XiuoFnMQZA5TguRU29P9s+x1Xlz3OqoCV0uygjTqCI+GO8DPBx6frc+T/
 4dAO9oh2zMoWGM1Sq2zC12uG/+EHcWZmagW1VQInKfvUDPoP1kWBW6YLUqMIgE4nYXfb
 BfGYsnVDqj3N5Gveteu3bcPD+nL429uqa3ZE9kfGNhqxqIADgsifZ/oymjt3UVPWcyOL
 kAZaQrtspt/FWhI7uA7bTZAkS9kHQPN5p1Fsy66u1Hm6UqwmHZ6Sv/fyQLyDj5E5v5RW
 WbxVweZdtQWN8KLTEBhBOVzFJdkDJYSl+fX3p3EXf/NczrLuwRBmymBDCF8Pc4N0Yzhe gA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkmrwr6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 17:46:40 -0700
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D183FC05B0;
        Fri,  7 Apr 2023 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680828400; bh=d3Qa2SmVGgV1eKz9DE9I32OcNteOqNL265gGRDJ3vDM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Vrs+QccdmXWb5SXNXItO9/MiO2APrPmoNFBaEaJK0tC5hDvUawRU0ZPcjYn78bLCf
         wLyrVdzdIwfNdtWAJH8OQKbG2VvUaFLvq/yXC2xqfWrPyozd/U2TigTC4ixHwYHw0f
         O0BJTYEMOPSA8OaAdHxMPozyHklstIdIG+ayV3E1syeETrnA24Z6B2cCkPBmm8BdjK
         OO5rEOuOou3Rq6zMou1i1rwJv99NfiuWtrmXGWlR3ZV34Ck69Vl61TvGx6W7D0Kozh
         62JD8osggc61NTJQeZln7Q1rPXEFU+34Rzmt6+1nXUVw4VgSQLhjuKXHNHr6+9Cxrj
         d6ETFXn1UWRVQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 551B2A005E;
        Fri,  7 Apr 2023 00:46:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 74EE7800BD;
        Fri,  7 Apr 2023 00:46:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="EIaZ1bBN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjaJqAxHsorU+qyriPqBkzhlOYF9pCTBXEbs7KPpJ3Jt7xk9WWBy5uV5pxEPL9kRP4lBAb3qqnhKHBcYgA7w5sSdwxRFh0yuWbHq82+uhF0fl/S3XSkLuljAOyJKucIkoUR3IMIlbGlBfLuEpOItmBm5xdmGV8vcSgMlrFubOyM6/3zLto/E1ClRTiDZxgtp+mlDnYEtFrhokj+a0N5pAnUmaAJg6LLIqGZCDwRXhjTzVW1If8dtNfJ4PYJ4TLiwl6SVu5EOvI/SWUX9HVRyCbSWuiu0hqg9EpYHlGkHd0Eh2FhvTRIqhrBTRBkM4sByUP8k/0ABFEU/Qadj5MMRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3Qa2SmVGgV1eKz9DE9I32OcNteOqNL265gGRDJ3vDM=;
 b=c1JPbIYgBwlyv+hayjgmYeHeaydHQqV4z0wI0+zLIVK6bLTPROSo7sBtRN/R3mtLv0uDBmfkz6CCFNHAr8T2X7a4V7zd/aOap32HhaiBes8wmXEpekvQDL1j/5Q4iG70AEA7mafivZBFW7U/11hsfFcYi4Ab3fyYN8ApS5Z9NoxFSJtzUzKAtq3llZAVEiyz6Ii51OpBL5XnTjO54brybX6MdwNqpEQ28qXsRUAa3fa+Ktb/2W3YzJBx/95oc5JhBGNCoR/ILbU1aQC+SI3uIIx28bYnnKbCBlHxrOp5jo37qsUjuP+CJRgbcNCruK76QD1lCh/NOQrtlyIYRA7ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3Qa2SmVGgV1eKz9DE9I32OcNteOqNL265gGRDJ3vDM=;
 b=EIaZ1bBN8RcEYYzdXmqAIBXa/pucTO/kgElkr/KZyJcAmC+1oPt+LH8dgOUSlC9zTUiIytAblZxxu1Ajlzr3S2cYfRUEZUOgRCZDGyksmcujxshfKDGjDLKlC42z/wyA0TVbaAaiRWNalb+/QqpvMrFVJCBSgEi1dIU2hAtY2Y0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 00:46:35 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 00:46:35 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/11] USB: dwc3: clean up probe declarations
Thread-Topic: [PATCH 11/11] USB: dwc3: clean up probe declarations
Thread-Index: AQHZZsayxlJ6eLyIkUesahI8Gjy4NK8fBy8A
Date:   Fri, 7 Apr 2023 00:46:34 +0000
Message-ID: <20230407004620.3z7jgnbuvnfvjyig@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-12-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-12-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM6PR12MB4578:EE_
x-ms-office365-filtering-correlation-id: debe21f5-801f-4f36-2833-08db370189b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aRcAqyw9vKzDztItHdUXekYRnEzjgrv/JMEs1xa4G7XfVjdE27G68QHyCt9xV2DF1O6/vULCS7eS/4epDvTVGruMfzmN0zG0RsOIayaoCdQUlqwH3evX/+EwdHzHIxHu+OCsEd/cwdRTf/duStHovzjm2s3JUEWG68pahplCwMevCN0y6JODu6lFpKr17QQmcXDtdx7vTDvqEFq5rvMkNrIrZ2pSRL0cMTRWPzYyFjfqynRNRHqfLZbbwdJEF9x37ieel29l4k2Kcf0d3UdyIFBmHtU9yslpM45Ad3uZJhycSnqgtpjFd3XBSqGQmnH0mQhxbsvvqa2iZ0tVEjsyvVLUFno9s3tsUv7mJ/zuoRNg76S/tlpIKLArvtCqQfEp/YfKoJoEurQHxGmyxd1C7Ve8YjDcwFJBVFSErzzSu2iW61+g9kDM0fXV9IMVt+IiZEVWecBZsFw3tll/iTng0YOi1XlJ8T7aLaNeigVTvbV02Ba8boW5Z5EdAhHawRSn5ArYqywedVMhxH7xdq6TgeCYkDrk4iNEOUKUxhtb8enoQQtX8ZHHptDdPFLUo9c6TCFrNWOwKGBP5hQhkOFlXwF2j24dZlt9KzX0o+osc8K3l9aEd6CP8etEQ/JlgghU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(316002)(6486002)(5660300002)(54906003)(478600001)(71200400001)(83380400001)(41300700001)(8936002)(4744005)(4326008)(76116006)(66556008)(64756008)(8676002)(66476007)(66446008)(66946007)(1076003)(26005)(6506007)(6512007)(2906002)(186003)(122000001)(2616005)(38070700005)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WURGa2RjcjNxdHdtQ2NoUnpQVHZiUmRjV005Tk1lMkF6cnBjZ05xcGtMSTJq?=
 =?utf-8?B?WnFjN1EzMk55K2VXaWxQVmt0WDlhVDlZTDdJd1FuTURHNkNRdGtmbnMvZGZx?=
 =?utf-8?B?Wms2Wis4NE95RGZQKzZHcGNaVDcwRGl2ZUlaaGcrWkFKdXQ3QldkQmNhQjYw?=
 =?utf-8?B?Z3N4NFpPSW53U2diQXpRdVJuWjJ3cHJKR3UwWWRyaEIrOCs4a0wrSTNvV3JU?=
 =?utf-8?B?TVdJa2V2MDdPL1BzMHZraitWQk5ZNC9UWUx6bTdUbkFualZGKzVzZWU4YXZl?=
 =?utf-8?B?VkZRYWhGak83b0dUZFdSUUxnMVozVEhUOUpCYWtBWk5oZ2tvaDhLNkIwZHdC?=
 =?utf-8?B?STdmU25ZS3k1dWFja041SStCVExKVkN0N0tLUzltbk1VZzZhNUZxZ2FIQXow?=
 =?utf-8?B?SjNSSnlzMGg3VmlJbUhmbWE0Wjg3N2hTclhoVzFublNrcS96c011SGVma1BO?=
 =?utf-8?B?T21UZkVCV004S29tYWlaSitpbkQrOGdSVHZxVTVPQ0xvenhpK0xQR1FJNjdC?=
 =?utf-8?B?TU95RFNvaTZaUnFMUUVwd0tqSGErT2NlWjNnY2IxNkFKcU9rUXlmS3JzeXZV?=
 =?utf-8?B?UDVYdWtVSlF6eUtDVlBmSmxOa3Y1MmVHQ0xvRmZCWUt1cnJ2SnZkR1V3MGV4?=
 =?utf-8?B?cGkwM0ttWHdINnk4bHZJZ3RvbzJXZGttOE5vQ1MyOFU0T0FkMVFFdnNQaGp5?=
 =?utf-8?B?bk1VR1ZwQVh5V3pMTm93aU41L0MzR0xLUk1mMmZYRjg4TlluRk5oTytGRWl1?=
 =?utf-8?B?V2hhd2tEUFphb3lGVEd5VW93dVE2dVNqTzE3VjYrUWwxTm1uaTZNQk04Sm1S?=
 =?utf-8?B?dHFzOENGemdGTHZ6STBkVkpwU2UwWk9ReVRPcFl5OHpyVzA5QjJ3Ry95Z0Fa?=
 =?utf-8?B?UVlnUStCRHVYR3hOWVhENFE3ZGQ5bkN1Q3htMU1YWGR0SDkzdGhKekVRUGNP?=
 =?utf-8?B?UTVsaXdzRGNIM1UycUVBQURWcUZNOU5kTG1UU0FFbm55NXlxR2x4TmhlSEs5?=
 =?utf-8?B?cEdHVG9CUXV5RW9ZbnRiSnEyVStDVTM3R3NQdGpBSUtCM1VxUThhd1NrZENZ?=
 =?utf-8?B?bVVUbW9vcjg3R2hkL2M0ZytyL3plalVRZDhsWmJWR2RjUGVPMkZWZWY2eDNP?=
 =?utf-8?B?Smw1ZjZTU1lMUDN3dk1xVSsxS2FnaHdmaEczdXlPSUU0eUt5S1UydWFsemZY?=
 =?utf-8?B?R3VFWXBrT1NyZ2ZPWERyQlpacG9idXNMblljQnM0ekd5VWJCbWcrcUZ5andy?=
 =?utf-8?B?aDZQSW5DZktXMzVNbXN5cW1mTkQrSVNsTXJndjJkbXB4VXM3bTBMZFZmd25I?=
 =?utf-8?B?VGpQZmQ5QW5sTyszN2ZDbkZPMHFIcU1IdEFrNTlFclQ4Q3N0QUtiQStUTzE0?=
 =?utf-8?B?UFBjdHdYRWp3QXlPSkt2SHhhNlF6dU1rTWdENWVyVWQvRjJrbWtjUXFxbGRC?=
 =?utf-8?B?bXh4ZTJTNUpKamlCWEpKQThaNDNTV3Y0TURFcHNOallaRGlQeTB1bXlxL2Q1?=
 =?utf-8?B?dXFXOVR2eDN1NzZIU1hyRXQwQTQ2d2tGdjZHaHFvOVJ2MW9IRkRlNC9Yclha?=
 =?utf-8?B?d3RVY1NwZWY1elJ0TXlCM0VsWFdITVo5R1FmSzZTYXpTSVBxOVN1bWNyOFlS?=
 =?utf-8?B?ZjlzTDN3RG9PSU5oVndzV0I0dzJRMDZFemMvUGVibHI3M2JOQ2YvNGJCdVBT?=
 =?utf-8?B?TTNNNFpIYUVzd0JRYTJnUlNFc2I3dm5qbmw4RVQ1bG5rdmtlV01VTkFPMVRS?=
 =?utf-8?B?bEl6QjhtcHRrOU1VWTdsSjJzTjdXd0k2dEJOY2ttdnJmVnptekFVY0hYN2Zv?=
 =?utf-8?B?TGZQSGpXSXNrWEpGMXNoUHVCQ010Tm9sK0Qyc0w5Rld2SGRNa05vQmZCb245?=
 =?utf-8?B?YW1EeHY2endOVENpMXFtRWtjU3JOS1JkekZ1bFJvRlZwM0wxZ2RIUEE1RkJI?=
 =?utf-8?B?MzZKTXdvQXRkdjBob2JWZkVxaEVDNTRlR21KSk9aM2krOERualVPcGYxTVM4?=
 =?utf-8?B?L2VMT2VGajBETUUrQ25pRUowRWNxZnh1NDErMW1LSnBkRGxFTkpJOXd3UzBV?=
 =?utf-8?B?cHROT2xHTzQrdERNU2xjSjRudnh5SVY0R293UE51S0syL1RVZmg4Q3RxVmJz?=
 =?utf-8?Q?oYM10i0xu3ZksuLP34RrulKlj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DF49A2CFC8B654FB84AF2993006705D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cTUR6Cr8s8DMy/2pP/G9mmmKC3SwedLKwr/pWGhfnZd3YAlDP6SFeEJ+AMR1POsohmcX4/WOY/itVyJ/VWs1YHEz3XENFF0ohIgtFHQ9uoVEeI3cfU0x/iXd9f4lIMYtd6Q+oZkbxGgfRtZLXlUrPCzPhS8kP5XxTmtdUazEmiEMxFF6fMqQdWKoyL4glRCgLRiC0JnmrTur/zVAtxb4PeoSxbolSWoRFFkUWxGvBzioPHVQ3U4Np34oAr5YzME+CovrLyGNSjBgtHVuOisRpGLtyTa2ZWuFuAfFxnDEsGTWQifkjU0i0ND4SI0h5hmavej5NdaKkuOBCoGXMZ4Kp+AjQR0VE5gUDla/4KT37gTVQQDemjkcpTEmd+e1zFw8Hb6fLDWsozbe/bP3xabw2kUbzU5gklM+OGVAtC/+ZUHUIjJayMnwoQwjpTm4gu6CSkTZ0IrwlONDviHEBJdoih9Q0+00CcLNA2DU6eE9PSzRl3uwjuIOa78SCJYRK/SVtsAo/LGJMiTqJ6lDiCmqpoDHdOPwyMClurhGTSF3m+DOT/h4pcf5BV8GbJ9UBLmkeMpjFLWMw8VGY2SZCHKfDrrUm3qz18Esy24hA9DlUdz4RrbGwxrJ9MBII9dcMJ3eeHFOmTPq6XxIqE4oBm+GDgHfNpogY2r2R81859b8p9f0W9rR3FRgEY7aBuxDyaQlSdk2Nn9LzSWu4EoVAKmrPq6mTExMRcn7pUfCpVTzypjrQOHflonI3hQdhiApxm7I3AuVg9yACKTP205n1crms/jTHpfu4QDeIiv1Qfj27LxRfzMPdpvCww22tOnKD+Gr/pPk0i8fKqmIJHgIo2TyA2i+tbUQpW1oJV3z1FJS5eF9UB6eFMcio+3XlClo6XoO
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debe21f5-801f-4f36-2833-08db370189b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 00:46:34.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OyJHpdqSE7ppkFISLyxnO5e7XObAjkoQeVCc2MuzzH/xU72wt4L/nFWtj0/Q3zNvxS2ytcJH2pU6f76ocKUX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
X-Proofpoint-ORIG-GUID: unx73Ff8cd_YtsuYRNu8vMdb130a4jDv
X-Proofpoint-GUID: unx73Ff8cd_YtsuYRNu8vMdb130a4jDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1011 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=985 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070005
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gQ2xlYW4gdXAgdGhl
IHByb2JlIHZhcmlhYmxlIGRlY2xhcmF0aW9ucyBieSByZW1vdmluZyB0aGUgc3RyYXkgbmV3bGlu
ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuK2xpbmFyb0BrZXJu
ZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNCArLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiBpbmRleCAwODQzMmUxMDlhM2YuLjI0ZDM5NWI4ODY4YyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
QEAgLTE3NTQsMTIgKzE3NTQsMTAgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldiA9ICZwZGV2
LT5kZXY7DQo+ICAJc3RydWN0IHJlc291cmNlCQkqcmVzLCBkd2NfcmVzOw0KPiArCXZvaWQgX19p
b21lbQkJKnJlZ3M7DQo+ICAJc3RydWN0IGR3YzMJCSpkd2M7DQo+IC0NCj4gIAlpbnQJCQlyZXQ7
DQo+ICANCj4gLQl2b2lkIF9faW9tZW0JCSpyZWdzOw0KPiAtDQo+ICAJZHdjID0gZGV2bV9remFs
bG9jKGRldiwgc2l6ZW9mKCpkd2MpLCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIWR3YykNCj4gIAkJ
cmV0dXJuIC1FTk9NRU07DQo+IC0tIA0KPiAyLjM5LjINCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBO
Z3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
