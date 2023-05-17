Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8570766F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjEQXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEQXce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:32:34 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC13A8D;
        Wed, 17 May 2023 16:32:32 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HN6Ken014929;
        Wed, 17 May 2023 16:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=P8rK0yCazJw7D0rD9pQsrMtQ9OgH2b8QDBht4tR4wDc=;
 b=k8be2u1mY10+HTq8K9HRIgNsV3oS5eE1Rfc5ZYktyD+Oux2zmMAr2QHg0qmvYHfBKYFl
 3gybnMGDCsXuI84EEaw2WTX21cDWvzX7IJtYVnHax7fvMb98JQ2qg+4wJ+fQ/rLJkK2I
 aN1LJPUvSxMl16ETuXCGGAVNz4blIGnyGOMAvoDkBgtzTB5rgyoYWTlrw10Ks0mX+99W
 H+J6E9FdgZxOLTpPKpotG21785zkWhuNLE5ycoB9rfghuwXzY3kXMV1cair6y55AAIsn
 QV990igVjVzwAO5PG/cJ6jTYONYLborBc3Hl3KUcKDitfnC2g/TTefg9nsQA3ZCa/DY4 oA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qj9ftqa93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 16:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684366348; bh=P8rK0yCazJw7D0rD9pQsrMtQ9OgH2b8QDBht4tR4wDc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Q8c1QoaWvD2ntzjVAGn6UR2sY0zXOBkO8xCa+QcJVh3ReZyeM1xFUXxzFtEEIbRaS
         yAO0Z7cHcugI8YivphxaxuMt46jPa3+/AzNshxNpjFj+2OU+ttEurAByNb6fYZqmhf
         KBVvHzS723uOppGNMA82+csStB/K31izkxmOs8sBjlC1ahfbU/BRitxyKzmFTVTJVc
         a2IabxfS64WdlziQ3jOwkrDl9iRyncC3ZHp4voprK7Y129YVCfujBvMlscsPK5WebI
         W+hfu9rBbQOm6aHZtm37OpSvvyO+rwlDvy+dRLkuSweCAi2n6I4lD0Wc3nsbBB95Zo
         QdpQy5sWmo0Uw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4E94E40636;
        Wed, 17 May 2023 23:32:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E7A16A0062;
        Wed, 17 May 2023 23:32:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rB+XJpN4;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0A4724063A;
        Wed, 17 May 2023 23:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUVfuLDTM1jTxYsZzeO8IXnESNERL0QYay0OvWg8V0ZlEQ07u8SnwdB4WHyUP0mGWeSdqCjnP911vMttcW7bBpkopwZkhhTodKAN4Rs4qiZQEf9sQf6U6GveN+2iV42Zf2T1/5qD3zzKS9ntBe9wdR87ZewR+M12NLDURvjceaGLVGAQdlk/2Rcqw9fvbHso4KF3aHluux7NByk1CofqX2vQFgpVgp58EoP+BbBqakXk2+zEaCN274/Fh78v0sODF4rcvAOkwipLDSgZGekbSD4Cupd8w+hek8ROez6xsZ3eOPtN5lx4P04O7GPZtt/uee8yBEgad+VsfXr1VZ9MTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8rK0yCazJw7D0rD9pQsrMtQ9OgH2b8QDBht4tR4wDc=;
 b=CGOwJle1r61EjlbnJWFhdgZnd0FmnDZfkFsIqwb0vqzhBLRmOgKkFD6Yos4mBUBD8mRw5TMOdCTMxe7ZGK2QKkvNP5IiJL0/7Ekiakcl33hhIbF56k57rRYSS6GN7SXaneFJx3zZLCUE1/Bz/I1U86pbxeQHSBojZ1cLIRuLfjYKUdOqJLOMSUZCQq3G/2P5bdbff/V0oY8CmGeRAQUi3GPiOGAMqpSrVHoYrrw+HNt06a7Wr1Ij/ijj9CMr0BYtXaGl9/omi+L0R5SFFHP4rS0eG7Uyu2/rDIdCR7W2Gn5Iclfxj1JzjXHYzFFOztdapMRvpmidWmxl5nIZlGZjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8rK0yCazJw7D0rD9pQsrMtQ9OgH2b8QDBht4tR4wDc=;
 b=rB+XJpN4FvEtwtmrDasJyLYTQtLVXmraiM0Nd4z7va+u0lwWWdY5NoX1qYk5C8z2KV7Z1bnWxmliltT0N8SKBwK+qUMz7flb+QB/vUW6AOuoEzeX2yNEKb7fIFAMu1WdGqcd2utdZMENf/mLtfKbdXtS5wPEf3YMlisNKRYeOso=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Wed, 17 May
 2023 23:32:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%5]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 23:32:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Topic: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Index: AQHZhnOYGWoDiciaPkad/64K3wvwX69dmz2AgAAFdYCAADDtAIABUR0A
Date:   Wed, 17 May 2023 23:32:22 +0000
Message-ID: <20230517233218.rjfmvptrexgkpam3@synopsys.com>
References: <20230514145118.20973-1-quic_kriskura@quicinc.com>
 <20230517001105.v74dyo6asqtcrpii@synopsys.com>
 <20230517003037.i7hsg6k5fn4eyvgf@synopsys.com>
 <f8882cef-0dfd-affc-1409-5cf0fcaad320@quicinc.com>
In-Reply-To: <f8882cef-0dfd-affc-1409-5cf0fcaad320@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB7344:EE_
x-ms-office365-filtering-correlation-id: 8db11f47-5340-4ea8-dbc6-08db572ef6c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBW+mFFKci+e9YJuf5yIpXzHqgz+36kLjisjhJsEMAtmCFjvkqhPkk1z1+RRdR+tSqVVHt+bM+p4puIQ0lR17s5uuIdMZPgHSKsvjthDtALsq0teLxvP/07oFJVCQKdqw0RSFl2XPVzBQf+LkKmBJle9s9f5sJBpAoclAThjGJxY1pLMwEMx622KGQQPchK4/1NNBDARRqSmvvnduT8zctxm9q6Y+FC55PZzje59X9LNGMy7w1sz9tsPAMHVtrnJyGgKVbf2cvDyXOd7MqNCK9voqlLjQAcleDNdi5+csrTwDqJvgoHeGCqRVZcWJser4+cL6197Pxw5adpkKcrJjJT+A9I9vQJNQRJwQpJMZkjMnT+JTnQNEWLz1wfwRgLNKe7QUqxyd4tI6tNuhQCP5A9as4v/HXxZI4Xonqwp7hVTNNtVZvWmFm9okxUPTa1B9usZrH/7AVqzRXzWf8sju4FW2DeqgH/eV4HKfBULoo2DCiqfVFA9Mo8cl10I2RgIOrfd1Mhf0QLDVFyqS7O5JhYqPdhKcGbJaCKvkAzfByttHansyzHY0kWzbqo6xxhe3C4gNUp1gKQA+pk+OiP0ToQKEJMzk0hIOFZuE6dEdykAgmFaJxJx/oxVom6p6mKVzwjgmUdR2FUbkrBMbImWow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(84040400005)(451199021)(66446008)(76116006)(966005)(6916009)(64756008)(66556008)(66476007)(478600001)(54906003)(86362001)(4326008)(66946007)(71200400001)(316002)(6486002)(36756003)(26005)(186003)(6512007)(6506007)(53546011)(8936002)(5660300002)(8676002)(41300700001)(2616005)(2906002)(38070700005)(122000001)(1076003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVpyWEhCcU05N0pkUkozUWI5ZmErRUt6S3FKbU8wTktJNVQ4cTNlbWF3UHpB?=
 =?utf-8?B?K29NTmpuTmRIQ3orbVMxWmZDeSt6U2lYZWljb3h6WnUrM3FrYzZWRmxjWjNQ?=
 =?utf-8?B?dDRkd2R6d3liSjBXbmM5d2lPREVHUjVraGpweG16NnFHYmxxUVVOellRQVhs?=
 =?utf-8?B?ZVhwbUNvVjM0OHV1Q3lrY0d6YWovMENRaWhBL3FMVHBsNWJwbzgvZ0Y2RXJn?=
 =?utf-8?B?MUVTMUh4Z3A1WHI4V3ZRNGt4SVJYS0trZGthSnZheUVhNVNGNEZVZVg4K1lN?=
 =?utf-8?B?Y1pWdktPWjIvSUhzWnJod3FOWEt1WEJiTU9DN0g2S3VFRGc3YVo5eWdiTWps?=
 =?utf-8?B?Z1doS1A4Ujk5Y1k1cEpwbFIxejFzaHdMV1REenVIQmxyVWVpZTg3VHZ4aG1o?=
 =?utf-8?B?eVRDK1grWm9XemoydlBsYndETVQzYnBqZm84Kzl4S2hWMUZzYUZFMnVDSE9m?=
 =?utf-8?B?dUNnVlBuelMvOFI5ZnBaaHVtYVhuencrRGtVTFlNSTVPRU1SS3p6MSthT3FD?=
 =?utf-8?B?SUlpNEk2alBWdzV3UFBOVm9kZXdwRXRtOFZTQ1l1dHlPcHFiSlhJaUZVcTR3?=
 =?utf-8?B?dFFKZDUyY1RFNnYxZE9zTVVkZFFlbndCeU02aWNjS3dYNWpFakQrRWFaQTV2?=
 =?utf-8?B?WWxnUlhCaThsWUk0N0NHUDJKa3hWZGdFM0FJKzhxQm8rNGdsUWZ5bnFaZm1l?=
 =?utf-8?B?VGNqbUhucFpTaHJCR1M2VnJvVXN4NHdYdm1iR0liT2c0VDdqVGtuMzdCUkV5?=
 =?utf-8?B?Q2ZHUnZpdS9VK05nQ29yWW01c3dvTlF4bDBqUGY2S0dCcnRjdldzZ3hqZlNP?=
 =?utf-8?B?OVlTS1lGM2ZRZm5LYU05NThJV1lwb21xS091QXNvdFBmUmpvMFJLT1VoUzBL?=
 =?utf-8?B?eW9iVzdvT0Y0M0JZbVZDRFY4bGtZVTh6dmU3dW9EV3czTlhRZWplOHZ1U0JJ?=
 =?utf-8?B?RjU1eFo4cUlQdzU0UHkwZ0hMN0RTdkxTblVyUFVOd1cvc3EwNXppckNSTWFV?=
 =?utf-8?B?bnhVNlM4cW5EY1RwWTVLOTh6dlJGYU9xZ0I5UzJqemlBODlvSlhibC81cFRn?=
 =?utf-8?B?YU1nODBFckJDVjRaVE1QQzRZM0F6c01TRzlmU1QrUlo5ZXdjZGFWUDNGRnRR?=
 =?utf-8?B?TmQyMS96RVRoTmZlVnBkYko4TGNhTHZ1RzRxM3lFd0pNdWtXY0c4VzArc2k0?=
 =?utf-8?B?MHY4d0JRY0MweTMvdGJCZmQ5RHVTTHJCRzRBOXl6ODBVbzRhcjNSMlQ2b1pB?=
 =?utf-8?B?ZVBhYUYrZ1BuNEI3YUZNalFVb0o0UmNyV1RUVWFKSytaY05Ybk9iaDU1T2xV?=
 =?utf-8?B?Ni9va1RlR3pRdXZvdVJnMGZRQWJ6K0RxY2JBcmtnWEYvTGQxcGVUQkNvODVs?=
 =?utf-8?B?SkFUdGlDZGdEeFhuV21yb1R4WjdXU0ZXRXVrblJGNGVwdGNrSDZKUDdpSkFr?=
 =?utf-8?B?ZlB1aDRjb2RQc0IzRHVMT1F2VDMzbGc1NUFEUEF5a2JHZFR1cTFmZ1pIcUZl?=
 =?utf-8?B?ME5TRGpsc2V6MW95OURoRlFXSWlHdFZkREtna3NGQ3NqZ04rQjBKV21KUkxr?=
 =?utf-8?B?bzNybTVUaG5DR1ZxZ3hBOHNuSE9OaHhzQ0FDWk9SelY0NStjbDFwZ3JqSzJv?=
 =?utf-8?B?ZHIreXdvKzBtNTVTdjBGWXZjcno3RWp0K1Noc0NCaldVdmJETitybzVieEY1?=
 =?utf-8?B?Q3dwTmVUZHdDaXMwWmQ4a3J1TXdXWi81bWJZRytRQkt2TUdRaWlUeGtjYjVC?=
 =?utf-8?B?Zno3S014UVJsWEFNa1pJSXkrR2NxWlR1WXF1U2hqWjZVenZvenhINUZ3VUVu?=
 =?utf-8?B?VlByQ01rNkFqWlVITlQyazVZOGRTSzJib1d5K3p6SHZ6ajRaUURxNlV3WFpN?=
 =?utf-8?B?SGt2S0VGUS8waGdWVGo1SnNQc3dFZ0ZyQkpqWkNROHdCd0FnNGwwemJXWWc2?=
 =?utf-8?B?R1BtRjc0Z09PcnlLK2x4aVdkSnJJYWY0bkZlcDlQZkdtWnl5ZEEyWTIzNnhJ?=
 =?utf-8?B?eDR2NUhyWU9rc0JvR1RGVjRxaXNqWWFpcVlobHcxdG1qemRMSTdacGpLNUJi?=
 =?utf-8?B?bWJrNjUxYmQvMGovUmYwQ0VSVzVoNW9UL0F4ZUpBTUdvUmJ5SGdXUG9TUWVq?=
 =?utf-8?Q?XEnol4E5PXz0iChhOOfmgL4AH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E19BBD0CEE2358499CC2AD348F979EC8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kX2I59ta8awg1sn2WTAlzN2hg8lhLqqUw9EoFkH01KTZFrM2V8LMA37hYwcwLU5G3XWL4soZKZ/zoQc3HH7EfA3weBE4Q1QO5FIMcqbUqm/MhqYXaTrl+Kp6kWY6vamgzIeY9kCIAHvhFEgjgSKQ5nyne/KxQF5CNUEkLQK30ec0v83KuuaocDXgV7Es8INPrFKNGRvTTX1dE09VAKPPlhjgTgFpty526IpIG68CRLneBbBa25KFyGu9rUDs87wo6DM9e1B/ATeylHcj9uVAReOkv0m5pCBLWGtKl1atQAv+6Aazl5/3DLnEK2FQbZZcr2Gnq6+LJ5BPufmuTsM3eJlSoWyw52ST7mShIZJPq8doOfp8ELQJ/gmbDwAFe/wCG5hhl1TRytn918SqGbnSjpisIyU7nmq9vgzgLpdMHNQbRVz2EUFWJDup+0ATMuKuS7ulnn5IzYNEmSzk6MKOM1QjpbAm0y5qoUDu8rc+ccXC55hfUaFw/Vl3MxpHC2uu8jOURFDotHNZXCI0IpYFqbhHYOONQ8kMgBgPnvdEIzom34gMzLYQU6etedzuRHUbbkNl4jN/L+LDK19CvpFn+aqqBC3tTWgL6FKOnGDuFzTZAZVldomFjfeCvVxTEDXayBumlwgnZoInknzGiihvG/WjtBI9XcfBRMpDc4pl58vSzp2iGXB7uiv0TB2UrRuAfUPogwFSBmBhTf0WyphMpQoX9aYhQbDnjU5Itu4HgNIqWsJI8z+YoFtJGkNOdxj6sLDMuo60pkoO/xAY9tKLrk4K/l3NBaC6/NKtHs/b0y6xtizUShNmpNq+Eo+nSc4QjH9WgqsbnvOdf/KEML6M4J4QQt2I+4CpIMvAHY/NRqNHOt1hqgAtTtcimZAvotA1lqXI8jwh6Xf2ztFvbO4LIw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db11f47-5340-4ea8-dbc6-08db572ef6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 23:32:22.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIjQ4Xmr9XjN7R+m5CYcf3VhumXjq1xJ4BfrlqbQAJPb17I2Q+6cWmdR90Pgw+yBwwP/tdrTFisKqWeEBnMbvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
X-Proofpoint-GUID: OnuYkdmMCGpFP5X7Yynu7yLC6ogxp7Xi
X-Proofpoint-ORIG-GUID: OnuYkdmMCGpFP5X7Yynu7yLC6ogxp7Xi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305170193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTcsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8xNy8yMDIzIDY6MDAgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBX
ZWQsIE1heSAxNywgMjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gU3VuLCBNYXkg
MTQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+ID4gPiA+IEN1cnJlbnRseSBmb3Ig
ZHdjM191c2IzMSBjb250cm9sbGVyLCBpZiBtYXhpbXVtX3NwZWVkIGlzIGxpbWl0ZWQgdG8NCj4g
PiA+ID4gc3VwZXItc3BlZWQgaW4gRFQsIHRoZW4gZGV2aWNlIG1vZGUgaXMgbGltaXRlZCB0byBT
UywgYnV0IGhvc3QgbW9kZQ0KPiA+ID4gPiBzdGlsbCB3b3JrcyBpbiBTU1AuDQo+ID4gPiA+IA0K
PiA+ID4gPiBUaGUgZG9jdW1lbnRhdGlvbiBmb3IgbWF4LXNwZWVkIHByb3BlcnR5IGlzIGFzIGZv
bGxvd3M6DQo+ID4gPiA+IA0KPiA+ID4gPiAiVGVsbHMgVVNCIGNvbnRyb2xsZXJzIHdlIHdhbnQg
dG8gd29yayB1cCB0byBhIGNlcnRhaW4gc3BlZWQuDQo+ID4gPiA+IEluY2FzZSAgdGhpcyBpc24n
dCBwYXNzZWQgdmlhIERULCBVU0IgY29udHJvbGxlcnMgc2hvdWxkIGRlZmF1bHQgdG8NCj4gPiA+
ID4gdGhlaXIgbWF4aW11bSBIVyBjYXBhYmlsaXR5LiINCj4gPiA+ID4gDQo+ID4gPiA+IEl0IGRv
ZXNuJ3Qgc3BlY2lmeSB0aGF0IHRoZSBwcm9wZXJ0eSBpcyBvbmx5IGZvciBkZXZpY2UgbW9kZS4N
Cj4gPiA+ID4gVGhlcmUgYXJlIGNhc2VzIHdoZXJlIHdlIG5lZWQgdG8gbGltaXQgdGhlIGhvc3Qn
cyBtYXhpbXVtIHNwZWVkIHRvDQo+ID4gPiA+IFN1cGVyU3BlZWQgb25seS4gVXNlIHRoaXMgcHJv
cGVydHkgZm9yIGhvc3QgbW9kZSB0byBjb250cmFpbiBob3N0J3MNCj4gPiA+ID4gc3BlZWQgdG8g
U3VwZXJTcGVlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3Vy
YXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBM
aW5rIHRvIHYxOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjMwNTEyMTcwMTA3LjE4ODIxLTEtcXVpY19rcmlza3VyYUBxdWljaW5jLmNv
bS9fXzshIUE0RjJSOUdfcGchZENnXzNXSzJvTlhOYjZkMGFfVnV5amtlZVpKVFUxYVk0ZGlrNmcz
NVhCN210RzdFSmVSMXVQTWZ4RmphNDlPZlhwN1loc2cxeXFqbnlsQ1lZRWc3WUNBaHFmQVowUSQN
Cj4gPiA+ID4gDQo+ID4gPiA+IERpc2N1c3Npb24gcmVnYXJkaW5nIHRoZSBzYW1lIGF0Og0KPiA+
ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsL2U0NjVjNjljLTNhOWQtY2JkYi1kNDRlLTk2Yjk5Y2ZhMWE5MkBxdWljaW5jLmNvbS9fXzsh
IUE0RjJSOUdfcGchZENnXzNXSzJvTlhOYjZkMGFfVnV5amtlZVpKVFUxYVk0ZGlrNmczNVhCN210
RzdFSmVSMXVQTWZ4RmphNDlPZlhwN1loc2cxeXFqbnlsQ1lZRWc3WUNEUkxVckpXZyQNCj4gPiA+
ID4gDQo+ID4gPiA+ICAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA4ICsrKysrKysrDQo+ID4g
PiA+ICAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCA1ICsrKysrDQo+ID4gPiA+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+
ID4gPiBpbmRleCAyNzhjZDFjMzM4NDEuLjMzYmM3MjU5NWU3NCAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gPiA+ID4gQEAgLTEyNjIsNiArMTI2MiwxNCBAQCBzdGF0aWMgaW50IGR3YzNf
Y29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiA+ICAgCQl9DQo+ID4gPiA+ICAgCX0N
Cj4gPiA+ID4gKwlpZiAoKGh3X21vZGUgIT0gRFdDM19HSFdQQVJBTVMwX01PREVfR0FER0VUKSAm
Jg0KPiA+ID4gPiArCSAgICAoRFdDM19JUF9JUyhEV0MzMSkpICYmDQo+ID4gPiA+ICsJICAgIChk
d2MtPm1heGltdW1fc3BlZWQgPT0gVVNCX1NQRUVEX1NVUEVSKSkgew0KPiA+ID4gPiArCQlyZWcg
PSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19MTFVDVEwpOw0KPiA+ID4gPiArCQlyZWcgfD0g
RFdDM19MTFVDVExfRk9SQ0VfR0VOMTsNCj4gPiA+ID4gKwkJZHdjM193cml0ZWwoZHdjLT5yZWdz
LCBEV0MzX0xMVUNUTCwgcmVnKTsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsNCj4gPiA+IA0KPiA+
ID4gUGVyaGFwcyB0aGlzIHNob3VsZCBiZSBkb25lIGZvciBldmVyeSB1c2IzIHBvcnQgcmF0aGVy
IHRoYW4ganVzdCB0aGUNCj4gPiA+IHBvcnRfMC4gVGhpcyBwYXRjaCBjYW4gZ28gYWZ0ZXIgeW91
ciBtdWx0aS1wb3J0IHNlcmllcyBpcyBhZGRlZCB0bw0KPiA+ID4gR3JlZydzIGJyYW5jaCB3aGVy
ZSB5b3UgY2FuIGNoZWNrIGZvciBudW1iZXIgb2YgdXNiMyBwb3J0cy4NCj4gPiA+IA0KPiA+IA0K
PiA+IENhbiB5b3UgYWxzbyBhZGQgZHdjX3VzYjMyIHNldHRpbmdzPyBJdCBzaG91bGQgbG9vayBz
b21ldGhpbmcgbGlrZSB0aGlzOg0KPiA+IA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gaW5kZXggMGJl
YWFiOTMyZTdkLi40YmQyNTY0YWExNjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+IEBAIC0xMjYy
LDYgKzEyNjIsNDAgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiA+ICAgCQl9DQo+ID4gICAJfQ0KPiA+ICsJaWYgKGh3X21vZGUgIT0gRFdDM19HSFdQQVJB
TVMwX01PREVfR0FER0VUKSB7DQo+ID4gKwkJaW50IGk7DQo+ID4gKw0KPiA+ICsJCWlmIChEV0Mz
X0lQX0lTKERXQzMxKSAmJg0KPiA+ICsJCSAgICBkd2MtPm1heGltdW1fc3BlZWQgPT0gVVNCX1NQ
RUVEX1NVUEVSKSB7DQo+ID4gKwkJCWZvciAoaSA9IDA7IGkgPCBkd2MtPm51bV91c2IzX3BvcnRz
OyBpKyspIHsNCj4gPiArCQkJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0xMVUNU
TChpKSk7DQo+ID4gKwkJCQlyZWcgfD0gRFdDM19MTFVDVExfRk9SQ0VfR0VOMTsNCj4gPiArCQkJ
CWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19MTFVDVEwoaSksIHJlZyk7DQo+ID4gKwkJCX0N
Cj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWlmIChEV0MzX0lQX0lTKERXQzMyKSAmJg0KPiA+ICsJ
CSAgICBkd2MtPm1heF9zc3BfcmF0ZSAhPSBVU0JfU1NQX0dFTl8yeDIpIHsNCj4gPiArCQkJaW50
IGxzcl9zcGVlZCA9IC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJCQlpZiAoZHdjLT5tYXhpbXVtX3Nw
ZWVkID09IFVTQl9TUEVFRF9TVVBFUikNCj4gPiArCQkJCWxzcl9zcGVlZCA9IERXQzNfTENTUl9H
RU5fMXgxOw0KPiA+ICsJCQllbHNlIGlmIChkd2MtPm1heF9zc3BfcmF0ZSA9PSBVU0JfU1NQX0dF
Tl8yeDEpDQo+ID4gKwkJCQlsc3Jfc3BlZWQgPSBEV0MzX0xDU1JfR0VOXzJ4MTsNCj4gPiArCQkJ
ZWxzZSBpZiAoZHdjLT5tYXhfc3NwX3JhdGUgPT0gVVNCX1NTUF9HRU5fMXgyKQ0KPiA+ICsJCQkJ
bHNyX3NwZWVkID0gRFdDM19MQ1NSX0dFTl8xeDI7DQo+ID4gKw0KPiA+ICsJCQlpZiAobHNyX3Nw
ZWVkICE9IC1FSU5WQUwpIHsNCj4gPiArCQkJCWZvciAoaSA9IDA7IGkgPCBkd2MtPm51bV91c2Iz
X3BvcnRzOyBpKyspIHsNCj4gPiArCQkJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdD
M19MQ1NSX1VTQjMyQ1RMKGkpKTsNCj4gPiArCQkJCQlyZWcgJj0gfkRXQzNfTENTUl9VU0IzMkNU
TF9TUEVFRF9NQVNLOw0KPiA+ICsJCQkJCXJlZyB8PSBsc3Jfc3BlZWQ7DQo+ID4gKwkJCQkJZHdj
M193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0xDU1JfVVNCMzJDVEwoaSksIHJlZyk7DQo+ID4gKwkJ
CQl9DQo+ID4gKwkJCX0NCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCXJldHVybiAw
Ow0KPiA+ICAgZXJyX3Bvd2VyX29mZl9waHk6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiBpbmRleCBkNTY0NTdj
MDI5OTYuLjQxNWUwMjE1ZmUwMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gQEAgLTE3MCw2ICsx
NzAsOSBAQA0KPiA+ICAgI2RlZmluZSBEV0MzX09FVlRFTgkJMHhjYzBDDQo+ID4gICAjZGVmaW5l
IERXQzNfT1NUUwkJMHhjYzEwDQo+ID4gKyNkZWZpbmUgRFdDM19MTFVDVEwobikJCSgweGQwMjQg
KyAoKG4pICogMHg4MCkpDQo+ID4gKyNkZWZpbmUgRFdDM19MQ1NSX1VTQjMyQ1RMKG4pCSgweGQw
N2MgKyAoKG4pICogMHg4MCkpDQo+ID4gKw0KPiA+ICAgLyogQml0IGZpZWxkcyAqLw0KPiA+ICAg
LyogR2xvYmFsIFNvQyBCdXMgQ29uZmlndXJhdGlvbiBJTkNSeCBSZWdpc3RlciAwICovDQo+ID4g
QEAgLTY1Myw2ICs2NTYsMTYgQEANCj4gPiAgICNkZWZpbmUgRFdDM19PU1RTX1ZCVVNWTEQJCUJJ
VCgxKQ0KPiA+ICAgI2RlZmluZSBEV0MzX09TVFNfQ09OSURTVFMJCUJJVCgwKQ0KPiA+ICsvKiBM
TFVDVEwgUmVnaXN0ZXIgKi8NCj4gPiArI2RlZmluZSBEV0MzX0xMVUNUTF9GT1JDRV9HRU4xCQlC
SVQoMTApDQo+ID4gKw0KPiA+ICsvKiBMQ1NSX1VTQjMyQ1RMIFJlZ2lzdGVyICovDQo+ID4gKyNk
ZWZpbmUgRFdDM19MQ1NSX1VTQjMyQ1RMX1NQRUVEX01BU0sJMHgzDQo+ID4gKyNkZWZpbmUgRFdD
M19MQ1NSX0dFTl8xeDEJCTANCj4gPiArI2RlZmluZSBEV0MzX0xDU1JfR0VOXzF4MgkJMQ0KPiA+
ICsjZGVmaW5lIERXQzNfTENTUl9HRU5fMngxCQkyDQo+ID4gKyNkZWZpbmUgRFdDM19MQ1NSX0dF
Tl8yeDIJCTMNCj4gPiArDQo+ID4gICAvKiBTdHJ1Y3R1cmVzICovDQo+ID4gICBzdHJ1Y3QgZHdj
M190cmI7DQo+ID4gDQo+ID4gICAtLQ0KPiA+IA0KPiA+ICAgVGhhbmtzLA0KPiA+ICAgVGhpbmgN
Cj4gDQo+IA0KPiBIaSBUaGluaCwNCj4gDQo+ICBTdXJlLCB3aWxsIHNwbGl0IGl0IHVwIGludG8g
dHdvIHBhdGNoZXMgYW5kIHNlbmQgYXMgYSBzZXJpZXMuIEJ1dCBtaWdodA0KPiBuZWVkIHlvdXIg
aGVscCBpbiB0ZXN0aW5nIFNTUCBwYXRjaCBhcyBJIGRvbid0IGhhdmUgYW55IGRldmljZSBzdXBw
b3J0aW5nDQo+IHNzcC4NCj4gDQoNClN1cmUuIEkgY2FuIGRvIHRoYXQuDQoNCmJ0dywgaXQgZG9l
c24ndCBoYXZlIHRvIGJlIFNTUCBkd2NfdXNiM3ggZGV2aWNlLiBTU1AgZGV2aWNlcyBhcmUgcHJl
dHR5DQpjb21tb24gbm93YWRheXMuDQoNClRoYW5rcywNClRoaW5o
