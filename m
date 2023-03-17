Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428EE6BF3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCQV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCQV3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:29:49 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFED12213F;
        Fri, 17 Mar 2023 14:29:47 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HLDpbC015575;
        Fri, 17 Mar 2023 14:29:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=d+iKDzq1dUO3qJq6EY0wQ7JsjgXDqFzuYBKeJ5j8D5E=;
 b=eqpsyDNWxzO6UI4jdI7BEPfiM0eIkhM1nJqq20h0czju9i/uL4fXjUUhTTHUYhnxUzdI
 4DaOXnCfnZPE5A4xvzYNEfPSClGcNxZodmdGp8DuB8/sjMqPNDembMKURtIrtNIci8vP
 VxRG2oIS098Gh74U/CJHlRC2mqkrWgb7vWRmXKG4OFrVyuU1FHHdnudvP9OO+cRHsZNL
 ytVLpIx9U249E/zMngYC3aVYMSLdKS+KpJuJlVR4uamnEcp7bCb9Dchtk4lbL6znTVbC
 aNd69XtbvwVrK68oDsTZwJhZNZEHpZrQknFPhD+mpBzM0btxAlRHDNeY77/KioJmyjgX GQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pbpx7jvf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:29:44 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6B6AE4008A;
        Fri, 17 Mar 2023 21:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679088584; bh=d+iKDzq1dUO3qJq6EY0wQ7JsjgXDqFzuYBKeJ5j8D5E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SEGWbY1o4kqNdaaRAP/tFlopXkVx2nJWn1oA4ZR4kISjBX+5smoEfSvG8Tkxlg+Pq
         3EuIU2SoeKxM/W9aGPPmeSbISxFzWv7cX1p4rz5tM4rg6/a4ZZxhX/Ixsu/sCwdlmb
         o7CCa94jLWU+lv4BhLzQczlyDe2TYYakkFlLjsx89LU0r+xR8fOQfHCBqqgBatovsM
         qdL+q9oYZAbaOtTxtUN8s0PoUdfyHREzttaQdr0R+Ko1npVZOotgmltDBVjvtEldF9
         mWeuFCIiDVHigTU2G+YDMSwO5xXe2eT5Rw4fLFPc7RoScd6JwTkXUViREgtSKQJUHf
         f0Mahk3+AZ7Yw==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id F18D3A0062;
        Fri, 17 Mar 2023 21:29:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D6F6940073;
        Fri, 17 Mar 2023 21:29:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="CaFVCQtj";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC6vqX0e3BSFnZJupjeSpmdQduYUkSMThQkb1VhSixrYKoWN3nAbq/w63P5SlLB3+R/5PsGVY+UaRJgsCytX+CVfq19dbV7DtyVCMSTJeFg6xEcurIsBZUgS/jN23HrvS9f7Z0Gj0Ef1LzI4dEk+VGXNRJ/R3exrCZCXdsoh7Cy/7fA/QQM8v9NRsixmOremFYsMKLd7LpyPxbgPirKbuLq8N+TQTxsNgGCYVJhwnDwtTZ/hNPUi4M4yH2lnhu2/8FrlraOzplyUlmqiunaZYFYimFtw5Y/KLafyYxUgaFmWzB8+9udi5WRVZTR2TlnGgrsE20C8VXIOyrFP3sd16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+iKDzq1dUO3qJq6EY0wQ7JsjgXDqFzuYBKeJ5j8D5E=;
 b=j0o6ksFT6JhRVBEpnPTR58Not9f6Pa2NP1Zd1+H1vQdCHC87wggBGeFoBY8KpjX0DNw0TwA/6nTTZypH7EjmjOVWN6r3ooLnv7NqW6kF81RNbNo1vq0+iymV6USP8FrD3/3QPcXNnbTXOa9b730UhfSeENP9Q1TenlincuqXhI/Yxapoyg/mdmORM5a2u18qwcNNFrVLhhzCzf94EAiVR6E3AiIzmh8Lfr+qDug6rzwMC14/MZkmnEjQKRdvHgvi3tYQj4ESpgGAmiaLfcC5CGhKYB8Le+PRyovwKk6q3/ypcLztnfivXMIap/QwaEhpAxTQ2SQfwsGmvehfUJXbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+iKDzq1dUO3qJq6EY0wQ7JsjgXDqFzuYBKeJ5j8D5E=;
 b=CaFVCQtj3JW6ncWuqpfl3Hg3IStKQ2q/l/zUDrKeXTx5zAjqvmcmgzolImOTTMuUKv0MlFa1aNRrGh42gvYl0wDe6AKnVS2jgHfNexigHz4kzQL3mU7ct5MtTXnEgA8eMMxd37ffmeoesiF4zK/zroMDAkLNEWVfJwRN+ZO58KY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 21:28:39 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:28:38 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZWGBkIcbTRueiF0WmOHHs1egwbK7+GWGAgAEqaoCAADpLgA==
Date:   Fri, 17 Mar 2023 21:28:38 +0000
Message-ID: <20230317212831.bcapq26jnuk2vkws@synopsys.com>
References: <1679009888-8239-1-git-send-email-quic_eserrao@quicinc.com>
 <1679009888-8239-7-git-send-email-quic_eserrao@quicinc.com>
 <20230317001149.nlvcj2y3fuvq32qt@synopsys.com>
 <0bf5bddd-515b-76b6-f22f-9da10a140d83@quicinc.com>
In-Reply-To: <0bf5bddd-515b-76b6-f22f-9da10a140d83@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7988:EE_
x-ms-office365-filtering-correlation-id: 82d7498e-9600-4649-98aa-08db272e92d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkMBDPVrLCnRRidd69YHBi159O7p0ZdCSCWMPMg/WeCzjxhndwW+5bD3c7w6tr0f0DbqfYNYrXvIXMsish11CUXIpD73gbEZoWIeSv3g2RpfYzR78x/omibvGH0o8Jr/3xZwWJbNYAy9tYuRrj44+am/nYzpspeoxNXZn8W/OrcOwrZ+T8xyl4syWTI8qrGC+WReFVonRIi6LjQCbFx0l8Oey6MdUfr5V9LQaCUAp1bWt4+IjqDolQh8VcbN6+z9aPdmh58WuOShUVFLwWdzzmKvYRhmhGdqib4ILQsA7iShbPXNMjMlD7fJj1P67TiwbNsE4N+jPfbvLSrWg++zrWOL74cTem0FTy2+hHTqA5Gb8MqWs/FITGZ3uKafQ3ei5vYujLVmKm2vWMxSImFMbtqPt09xw2wbUbFFwALzpJ+mHLJRB45EP/t+h0s/lKNxOZ5wv5EAW2cBrhByFVEojs9fnZ19p/K8OlTERQr8Adl5PcQrX74YGjdiPVElqztyNOD8aZLq7F0aJLGlzKtnpHGcBPzBV4LVSSk9ccXxbzrzWoPfzlTcKjQliWCJ+5e45XvLEFoNzi23LkyNDS9zKCAgPkQc0E+pMxscQRl8CENcZgo3Xw5E+TsM4UCQjNMOKfigTV9kWhcAnCy3296EEPhaq7xicD445m7gsJTBZwLrBr8PQLDvvgGQCWHLC43kT8Q+bWpL3vDlEMVXixl7TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(316002)(478600001)(38100700002)(122000001)(76116006)(71200400001)(36756003)(66556008)(64756008)(66446008)(8676002)(66476007)(6916009)(4326008)(66946007)(38070700005)(86362001)(26005)(6512007)(1076003)(53546011)(186003)(5660300002)(54906003)(2906002)(41300700001)(8936002)(83380400001)(15650500001)(6486002)(2616005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW5GVEFVbXJyd2xpd3F3Z25rQ1R4YkhXSjhTa3p6ZkNyUHJUaEIxb2hkNTI2?=
 =?utf-8?B?NkVSNVJlWEEwNXNZaWhJUVBKN3hhS2dHYlk1ZkZ4RzN0S3ROdUZIczVvdTE2?=
 =?utf-8?B?QTdveUNGYkRMOWd3Y0hQUFhIbUZwZDhtcHZtUXI3L0t1UlFNbTQ5enNYTTJw?=
 =?utf-8?B?K0dUVmFpakx0SU9tUXAxSVFDeVk0TThHNFAyc1FKVE4vQ085NzZMem1Ib3NG?=
 =?utf-8?B?eGQxRUpuVkNYcVphQVltRGM4OXYrcTRUM2VDY1FzeEQwdklMalhra2RidzJJ?=
 =?utf-8?B?VWJOQlRlci9LbEwyQmdvQ2YxTW85RDB4TTh4WWpqVHlSQkJQRGlETk9Hbk1z?=
 =?utf-8?B?Umh4S1dHdENnOTB2TnREckxMRVpYOGY4eXUwelJmRDcvdXE1OFJWa1RQT0ND?=
 =?utf-8?B?MkdSTmJ4QXZobzVycEhPa3FRMUtDYjk1cVoxU05xeGZybjQxYWVBUDNOTHQ5?=
 =?utf-8?B?bDRQUEVzbUs5TEE2WjZmaFBqRG5HRm1yaHhwR1dicWswbHl3SlViNDJIZThq?=
 =?utf-8?B?aHpaeWV3K3ZBa2o0TjlXOVJTNmNLeVdPVXhkeVVjVHBnRUhzV3cyS0ZYSjFI?=
 =?utf-8?B?MDJ1VjRtOW9rUUVNaU5zZkZJN2JKQ1c5YVEybEZOdVBrempNS29uTExmZDMz?=
 =?utf-8?B?aUNxaCtrZzY1azZ1U3RhUXVjSGFYRHhHbEFyTlVVM2JXYU1ybWphTG9RZ0VB?=
 =?utf-8?B?TXQ0MU1hQ1YvbHhnOHViUXl2VnpreFhoU2tBWUtqQWR2ZW1ZT2J5OGRRUmdH?=
 =?utf-8?B?Q2kzMkFiVk5PY0R0MlovQ3hnQnY3VjZyVHlzM0g1eWNBY2hSSmFPckhoLzhs?=
 =?utf-8?B?U01UUnJKQ1U3R2l5cjdua3J3bXVXTksyVjNka2RsMHMvOFdhbk1COXEzT2Zs?=
 =?utf-8?B?cUZQdU5obC9ZQ2ppa1F4eS81ZS9uWHRGdi9Nb29EK3VRdTdkZzh4NkZ3Ui9R?=
 =?utf-8?B?WVpaVS94MXZqdWZlREpVN2hCV2FlbFNBZkJ3c0NtOUFVTDNCUkJCQWh4enkv?=
 =?utf-8?B?ZzhmdE9tUHZwcHlqeWl3SWk1K21EeXdHZkdESERpRlhJWlZrOFlpTVNqTlM5?=
 =?utf-8?B?QWMwcFo5RVFVL1pyejdhTWhYNVFobXlGUjNsSW8wNFV2RWxDOFhGTEU5R2ZZ?=
 =?utf-8?B?RnpQbnBucm90bnUzNWRwY0Z4YlNmc2RDeDNsckJFVUZQanQ3Q0plb05OSEFn?=
 =?utf-8?B?WU85LzFQUzVsUTNaaDI2dUNqTTYwVE9hZ3pkNjNaeTJ4bXZoVS8wSGphbGRq?=
 =?utf-8?B?L2lUN3FtN1dOUGRvRGhvRnhmVkRVeVRBVUJPSUJNU3pieXhINnFLc2VzaTJj?=
 =?utf-8?B?WWNWTXNLNmJra0hHaUE3bWNoTWxEZ3ZqQnBOdTh0U3dJSnl2bHlNSk9yWTI0?=
 =?utf-8?B?bm94d1FQdE9xd1hnYlRJM25YMHBiekttd3NSSFJuTnJpME1iaUYxWkVrN1k2?=
 =?utf-8?B?VXJoVEZFVFZFaXhqN0Q2cmQzQStJeUUyeStHOTJiSFVQQTRhb0szWHJnRCtE?=
 =?utf-8?B?bTRCNTEwdnQ4QUtQbkdlWGtkZ0dkSFJNakp6emhSU3JBOEQ3Vmd0aEt5UVcw?=
 =?utf-8?B?UmR3MysrUmJTNjd4YVpEVWJuWDRETHRUOSs4aGovckQ2c0lGMUxwZFByeDFN?=
 =?utf-8?B?YmFHdzFjb0Y2S25UNzJScXZmTEhoTFd3M0tKYXFwNlg4YkhQdkllVmVHSmtR?=
 =?utf-8?B?Q0xzcEZvcyt4R2wzTWttdXViNkYzMVB3emZucldzc2dZcVRISWpVYVBqUCtZ?=
 =?utf-8?B?ZE11N25HSFRhQURmOUFrUFdvN05OQjA5MkR4M25PMUxFdUZuK09QTFZlYWtW?=
 =?utf-8?B?b2g5QXI5bmoyNEFLOXVqbm5SWUdUUWRwTXQ5Sk9UYm1JeTRiK1YwTm1wa1Zk?=
 =?utf-8?B?YUZZQ1ltajRqQU90bGFMVGxiT3h4Tk1SYVVOem1yQUNBN2xmOXVxZlR1cDlt?=
 =?utf-8?B?ZC9weFpkUDUyVXVadldDbTVnc3hObXpQTG1CUFBsWU1lS1RBUGhyaWRtcXZz?=
 =?utf-8?B?RzlsTkdzUDN5S1NJTEFOQkhMNXVKNGJRd3ZnY25NUE1WVW80QXR2T1pvRFYz?=
 =?utf-8?B?d0ZsaHpVMkttWS9WMmJFM3NmV1FwSUxZei9uOFZXVDVDV3p6eGlHWnFaUnlJ?=
 =?utf-8?Q?nbw4GAw88Yok2aEPwAb0Iuew9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <923DB9E1E09F7C4482B3FC7A6356DB41@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: prZfDjsutodon7P1lhIjzeLP+uK9Mlfh1mCRU5x/Y+ct3T/BWSsQrSntR0qRvBzzLD+WO93E8OtMYr59dp9U0nxPYUWL84KUmxBF0RNS2//Rb/0IRUVs2NlOCyp45ifonPlyMav3sCJ6NrS3T/eCZRov/uZy9rAVdnqlQ+WnP3IHFC20ev3UJRXlZgbn4XIxXZcv+iWtsIiBDQnQkQpXMKCKUUCfqDPDbGv0kfudqB5pch5wADZeOrRDnSWJvvOL85HSJnBA3MIelfwE3Y0TXFDi39F+o5stxuh6V/yfNvqej/gvYOgQTxwijkYyev364paBi8SNAMgHEs68YCkfP+B2ZlHSc74Z/cj/iHJgK0BxVgsii94fPyeUwD08dUN2J3GufG1/ao9X6F7t84VEfKLqobKTQhxTVMoC/OITn/Ct1814k+JFrGKiNcnbsuXvGPagK9WT9bAMjDu1+ebi13Bf0oq1pjaCHPAbkisJEpkr7l3qBVMVZBpI+Z6B+C2ICw3Bp8VYWidYzBiTFRsMzjLsKLfuHdeZgNcTGbCRJlA9ikevI1EXsMc65SiDj6zHxEdlc4ds08XkmJ+iA+3SE/OCMoRL0vjQC5bLsCEggoa89g7+e8aaVkKYROFDQdPw668ORxWLtLu6bNexpwJ0ubRxuVZ+TziuJlTjIBIr7tbXZLgFjuGWhzs+Bieeej0KYvL4aqbH0mXrUMBnALgMdYdOeWvmoLsy+8ooDyZwrUhXAGuZu7JZEKOkaMVbnjiMmo86uVGcs6AjVMaIYpU3F8m1kyGcb4wStFgJAN+lpVwXrWkbpeOw+uOWfCsX3BRcKAYM9zqvNBOC7jxiLAql8BcKSSb/hPMnswjqjPmbl26MgNk0FwKkbtNxBbnkADAsSk4e95M/3MHtktsYQsTprQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d7498e-9600-4649-98aa-08db272e92d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 21:28:38.7948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPmoV4SjgOpIES1HH1YspgQsxJzz/AT9zIR8qjHia9KxGiAbjo/UTXQGioEHfcm9SNFCHBIe7LQ/7krR57eG9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
X-Proofpoint-GUID: M0X_-J0BiKEfcoOlp4i20L0Khwoyv73t
X-Proofpoint-ORIG-GUID: M0X_-J0BiKEfcoOlp4i20L0Khwoyv73t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303170150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMTcsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAz
LzE2LzIwMjMgNToxMSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFRodSwgTWFyIDE2
LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3RlOg0KPiA+ID4gV2hlbiBob3N0IHNlbmRzIGEg
c3VzcGVuZCBub3RpZmljYXRpb24gdG8gdGhlIGRldmljZSwgaGFuZGxlDQo+ID4gPiB0aGUgc3Vz
cGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3VwZXINCj4g
PiA+IHNwZWVkIGRldmljZXMgY2FuIHN1cHBvcnQgZnVuY3Rpb24gc3VzcGVuZCBmZWF0dXJlIHRv
IHB1dCB0aGUNCj4gPiA+IGZ1bmN0aW9uIGluIHN1c3BlbmQgc3RhdGUuIEhhbmRsZSBmdW5jdGlv
biBzdXNwZW5kIGNhbGxiYWNrLg0KPiA+ID4gDQo+ID4gPiBEZXBlbmRpbmcgb24gdGhlIHJlbW90
ZSB3YWtldXAgY2FwYWJpbGl0eSB0aGUgZGV2aWNlIGNhbiBlaXRoZXINCj4gPiA+IHRyaWdnZXIg
YSByZW1vdGUgd2FrZXVwIG9yIHdhaXQgZm9yIHRoZSBob3N0IGluaXRpYXRlZCByZXN1bWUgdG8N
Cj4gPiA+IHN0YXJ0IGRhdGEgdHJhbnNmZXIgYWdhaW4uDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYyAgIHwgNzEg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAgZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuYyB8IDYzICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiA+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuaCB8ICA0
ICsrDQo+ID4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTM4IGluc2VydGlvbnMoKykNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jIGIv
ZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMNCj4gPiA+IGluZGV4IGE3YWIzMGUu
LmM0M2NkNTU3IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L2ZfZWNtLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5j
DQo+ID4gPiBAQCAtNjMzLDYgKzYzMyw4IEBAIHN0YXRpYyB2b2lkIGVjbV9kaXNhYmxlKHN0cnVj
dCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gPiAgIAl1c2JfZXBfZGlzYWJsZShlY20tPm5vdGlmeSk7
DQo+ID4gPiAgIAllY20tPm5vdGlmeS0+ZGVzYyA9IE5VTEw7DQo+ID4gPiArCWYtPmZ1bmNfc3Vz
cGVuZGVkID0gZmFsc2U7DQo+ID4gPiArCWYtPmZ1bmNfd2FrZXVwX2FybWVkID0gZmFsc2U7DQo+
ID4gPiAgIH0NCj4gPiA+ICAgLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8NCj4gPiA+IEBAIC04ODUsNiAr
ODg3LDcxIEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2luc3RhbmNlICplY21fYWxsb2Nf
aW5zdCh2b2lkKQ0KPiA+ID4gICAJcmV0dXJuICZvcHRzLT5mdW5jX2luc3Q7DQo+ID4gPiAgIH0N
Cj4gPiA+ICtzdGF0aWMgdm9pZCBlY21fc3VzcGVuZChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0K
PiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShmKTsNCj4g
PiA+ICsJc3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2ID0gZWNtLT5wb3J0LmZ1bmMuY29u
ZmlnLT5jZGV2Ow0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4g
PiA+ICsJCURCRyhjZGV2LCAiRnVuY3Rpb24gYWxyZWFkeSBzdXNwZW5kZWRcbiIpOw0KPiA+ID4g
KwkJcmV0dXJuOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCURCRyhjZGV2LCAiRUNNIFN1
c3BlbmRcbiIpOw0KPiA+ID4gKw0KPiA+ID4gKwlnZXRoZXJfc3VzcGVuZCgmZWNtLT5wb3J0KTsN
Cj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHZvaWQgZWNtX3Jlc3VtZShzdHJ1Y3Qg
dXNiX2Z1bmN0aW9uICpmKQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGZfZWNtICplY20gPSBm
dW5jX3RvX2VjbShmKTsNCj4gPiA+ICsJc3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2ID0g
ZWNtLT5wb3J0LmZ1bmMuY29uZmlnLT5jZGV2Ow0KPiA+ID4gKw0KPiA+ID4gKwkvKg0KPiA+ID4g
KwkgKiBJZiB0aGUgZnVuY3Rpb24gaXMgaW4gVVNCMyBGdW5jdGlvbiBTdXNwZW5kIHN0YXRlLCBy
ZXN1bWUgaXMNCj4gPiA+ICsJICogY2FuY2VsZWQuIEluIHRoaXMgY2FzZSByZXN1bWUgaXMgZG9u
ZSBieSBhIEZ1bmN0aW9uIFJlc3VtZSByZXF1ZXN0Lg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJaWYg
KGYtPmZ1bmNfc3VzcGVuZGVkKQ0KPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4gKw0KPiA+ID4gKwlE
QkcoY2RldiwgIkVDTSBSZXN1bWVcbiIpOw0KPiA+ID4gKw0KPiA+ID4gKwlnZXRoZXJfcmVzdW1l
KCZlY20tPnBvcnQpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW50IGVjbV9n
ZXRfc3RhdHVzKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1
Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmMgPSBmLT5jb25maWc7DQo+ID4gPiArDQo+ID4gPiArCS8q
IEQwIGFuZCBEMSBiaXQgc2V0IHRvIDAgaWYgZGV2aWNlIGlzIG5vdCB3YWtldXAgY2FwYWJsZSAq
Lw0KPiA+ID4gKwlpZiAoIShVU0JfQ09ORklHX0FUVF9XQUtFVVAgJiBjLT5ibUF0dHJpYnV0ZXMp
KQ0KPiA+ID4gKwkJcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAoZi0+ZnVuY193
YWtldXBfYXJtZWQgPyBVU0JfSU5UUkZfU1RBVF9GVU5DX1JXIDogMCkgfA0KPiA+ID4gKwkJVVNC
X0lOVFJGX1NUQVRfRlVOQ19SV19DQVA7DQo+ID4gPiArfQ0KPiA+IA0KPiA+IFdoeSBkbyB3ZSBu
ZWVkIHRvIGltcGxlbWVudCBlY21fZ2V0X3N0YXR1cyBpZiBpdCdzIGFscmVhZHkgaGFuZGxlZCBp
bg0KPiA+IGNvbXBvc2l0ZS5jIG5vdz8NCj4gPiANCj4gDQo+IFllcyB0aGlzIGNhbiBiZSByZW1v
dmVkIG5vdy4gV2lsbCBtb2RpZnkgYWNjb3JkaW5nbHkuDQo+ID4gPiArDQo+ID4gPiArc3RhdGlj
IGludCBlY21fZnVuY19zdXNwZW5kKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYsIHU4IG9wdGlvbnMp
DQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBmLT5j
b25maWctPmNkZXY7DQo+ID4gPiArDQo+ID4gPiArCURCRyhjZGV2LCAiZnVuYyBzdXNwICV1IGNt
ZFxuIiwgb3B0aW9ucyk7DQo+ID4gPiArDQo+ID4gPiArCWlmIChvcHRpb25zICYgKFVTQl9JTlRS
Rl9GVU5DX1NVU1BFTkRfTFAgPj4gOCkpIHsNCj4gPiANCj4gPiBUaGlzIGZlYXR1cmUgc2VsZWN0
b3IgZG9lc24ndCBpbmRpY2F0ZSB3aGV0aGVyIGl0J3MgU2V0RmVhdHVyZSBvcg0KPiA+IENsZWFy
RmVhdHVyZSByZXF1ZXN0LiBlY21fZnVuY19zdXNwZW5kIGlzIHN1cHBvc2VkIHRvIGJlIGZvcg0K
PiA+IFNldEZlYXR1cmUoc3VzcGVuZCkgb25seS4gUGVyaGFwcyB3ZSBtYXkgaGF2ZSB0byBkZWZp
bmUgZnVuY19yZXN1bWUoKQ0KPiA+IGZvciBDbGVhckZlYXR1cmUoc3VzcGVuZCk/DQo+ID4gDQoN
Cj4gSG9zdCB1c2VzIHRoZSBzYW1lIGZlYXR1cmUgc2VsZWN0b3IgRlVOQ1RJT05fU1VTUEVORCBm
b3IgZnVuY3Rpb24gc3VzcGVuZA0KPiBhbmQgZnVuY3Rpb24gcmVzdW1lIGFuZCBmdW5jX3N1c3Bl
bmQoKSBjYWxsYmFjayBjYW4gYmUgdXNlZCB0bw0KPiBoYW5kbGUgYm90aCB0aGUgY2FzZXMgPyBU
aGUgZGlzdGluY3Rpb24gY29tZXMgd2hldGhlciBpdCBpcyBhDQoNCkhvdyBkbyB5b3UgcGxhbiB0
byBoYW5kbGUgdGhhdD8gUGFzcyB0aGlzIGluZm8gaW4gc29tZSB1bnVzZWQvcmVzZXJ2ZWQNCmJp
dCBvZiB0aGUgIm9wdGlvbnMiIGFyZ3VtZW50PyBJbnRyb2R1Y2UgYSBuZXcgcGFyYW1ldGVyIHRv
IHRoZQ0KZnVuY19zdXNwZW5kKCk/DQoNCklmIHRoYXQncyB0aGUgY2FzZSwgdGhlbiB5b3UgbmVl
ZCB0byB1cGRhdGUgdGhlIGRvY3VtZW50IG9uDQpmdW5jX3N1c3BlbmQoKSB0byBhbHNvIHN1cHBv
cnQgQ2xlYXJGZWF0dXJlKHN1c3BlbmQpLiBSaWdodCBub3cgaXQncw0KZG9jdW1lbnRlZCBmb3Ig
U2V0RmVhdHVyZSBvbmx5LiBBbHNvLCBtYWtlIHN1cmUgdGhhdCBvdGhlciBleGlzdGluZw0KZnVu
Y3Rpb24gZHJpdmVycyB3aWxsIG5vdCBicmVhayBiZWNhdXNlIG9mIHRoZSBjaGFuZ2Ugb2YgdGhl
DQpmdW5jX3N1c3BlbmQgYmVoYXZpb3IuDQoNCj4gU2V0RmVhdHVyZShGVU5DVElPTl9TVVNQRU5E
KSBvciBDbGVhckZlYXR1cmUoRlVOQ1RJT05fU1VTUEVORCkgd2hpY2ggY2FuIGJlDQo+IGVhc2ls
eSBkb25lIGluIHRoZSBmdW5jX3N1c3BlbmQgY2FsbGJhY2sgaXRzZWxmLiBXZSBjYW4gYWRkIGFu
b3RoZXIgY2FsbGJhY2sNCj4gZnVuY19yZXN1bWUgc3BlY2lmaWMgdG8gQ2xlYXJGZWF0dXJlKEZV
TkNUSU9OX1NVU1BFTkQpIGJ1dCB3b250IHRoYXQgYmUNCj4gcmVkdW5kYW50IGFuZCBtb3JlIGNh
bGxiYWNrIGhhbmRsaW5nIG9uIGZ1bmN0aW9uIGRyaXZlci9jb21wb3NpdGUgc2lkZSBhcw0KPiB3
ZWxsPyBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBvcGluaW9uLg0KPiANCg0KV2UgYWN0dWFsbHkg
ZGlkbid0IHByb3Blcmx5IGRlZmluZSBmdW5jX3N1c3BlbmQgYW5kIGl0cyBjb3VudGVyIHBhcnQu
IEl0DQpzZWVtcyBjbGVhbmVyIHRvIG1lIHRvIGludHJvZHVjZSBmdW5jX3Jlc3VtZSBhcyBpdCBz
ZWVtcyBtb3JlIGludHVpdGl2ZQ0KYW5kIGVhc2llciB0byByZWFkLiBMZXQgbWUga25vdyBob3cg
eW91IHBsYW4gdG8gdXNlIGZ1bmNfc3VzcGVuZCgpIGZvcg0KYm90aCBjYXNlcy4NCg0KVGhhbmtz
LA0KVGhpbmg=
