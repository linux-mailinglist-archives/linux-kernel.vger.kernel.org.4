Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6A6A5109
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjB1CTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjB1CTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:19:51 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6DE11EB0;
        Mon, 27 Feb 2023 18:19:50 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S1RGr6025447;
        Mon, 27 Feb 2023 18:19:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=tEmwpAhaZMvme13UHuhqUy+IXS4fyr+IEjMU3lFTI+8=;
 b=qBP8wm0k4ehwkqWlSUAs0rKc/2ZyTUqdM4BynekTvYsj1zUiFO2V/q+QAdQAensDBfRD
 3O7Om0Yz00N1kNwD+MXPE3krMRhbIRJUSIrt60AVsVR0aHFNuepRu1MkOyLZeYK5wCfu
 Vynb+MdAJcpuokPxZcAx9xqjuXP5hbvaVBoTSOqLoo+0SeTNmjJvh0HIVwU7Q64JAfFr
 v/wxFmd1InG1xdgGMLW7reCmMOWY1EVd72BMf2iWv7LC8ow8udVvE53wT0BzEM5eYB6+
 g7BLNDqYdPfLxvKg0YVZfdwQ0iYRGY6xC7QlajrDuJnhxXA+ZT23na0hjerzig0gZf8S rA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nyj7u12gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 18:19:46 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D5B23C00F4;
        Tue, 28 Feb 2023 02:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677550785; bh=tEmwpAhaZMvme13UHuhqUy+IXS4fyr+IEjMU3lFTI+8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h35FSa8lRTO3VR+6abZ2y6xlStW0Kvk8dVQyHJwBXxFWOoN1h08G0ytVCq7Gwi69l
         qVaZXfNRS8b46NCf8g21sSnKE0WwYxf0GySMWCdbdxW0s2prLaH++TGWbnHKf74muu
         c33u9yfW8D47OLudryR/6DSRoZhAO3uhm4Jw24WqNPBLm23BP7l/UpXtR2r+tek5uw
         oxLaIa1dvZzP/EBmMYjps5q5Hnx/foZnxgtRyQlqk7haORnLGeCyJsEhXZJr+qToZQ
         acP3L6RQaV1/tlRywByFvQbqeQTWFjg2+isSwcUGrVsw9gNIB5U/WiuSSpDm8oaaVf
         hXX7kcSgtYgRA==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 43C12A0062;
        Tue, 28 Feb 2023 02:19:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D625FA00CE;
        Tue, 28 Feb 2023 02:19:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="hGJqK07q";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsnIRr+5m60mu5+HIpFoCcVQU7IP1rHfKuKnv0oM9GBLazp0jeFDZ2Lma6hYaHKxTEBB/qP063r8YpGf1rAFRZtD4YdnYVfsYs81FWJWXWvrDvKLipYEk/DVCyJH9AYeC7/1DppRk2h/K7fLWoNDbkdqKq9MoGCEg/86Eim8vkOHNL/lBYfdDvDTRNd4Lyp/vWg/w8ExSJmHYPFIYEhuTEGD6ZO+ze4m1yFWeJ1FCnGIMc/wWA7aYS2MsVWs0LKMk37yfDJu3CcecLK+7CL0VCsdWqAjKFz9lEw1fXsYb6wp947jhqGei0J7qmWTSSJyZD4/DDwkkT7WWvjZ4oYWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEmwpAhaZMvme13UHuhqUy+IXS4fyr+IEjMU3lFTI+8=;
 b=dcSIQnzt3nOK04fDzuu0+vcfeQH+eC+E3NXvni3QHZ3gfLuoAcpEjvTuu450u5laCvgPkxX+by4aOobQ+c1/6l1aqpwo6D09V0+g8JShM3H0dAjbz2Snho0WIIH1lOiqHJk9JBushtEwers4EZjdQcXJrHKkh5yL3QtF/kembqDkSS6uTj00vCVC09dNPwDj+fNfRlmu75AQOgISll/JPxtlONo0FGIEWqZMPFsufAw3jSp57/6zif6EGh3wMZMTw/G3wuEf6hnLPeHLL2KpEd8uXprv0vZrS8pikppdS3WnBqfTHU6545pnMjquaJDpsuaPwpGiW074KfRT32S3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEmwpAhaZMvme13UHuhqUy+IXS4fyr+IEjMU3lFTI+8=;
 b=hGJqK07qF2s4fE6txGMZfuabkfkKjqIfyG4mxGC6k/y3PwP4P5qRLvAcrNmpqEoZDGLbZPp9oRlESffN1KphbUr4XJd07HHyPySr/VUSJaOtpgv0l1bBU3ImBunlataLf3izsYchbJzyia4t+lYTKkKhaWtHrNm9oZaW81E1fME=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 02:19:40 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::5dd3:596e:ee5f:ece5]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::5dd3:596e:ee5f:ece5%6]) with mapi id 15.20.6134.027; Tue, 28 Feb 2023
 02:19:40 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Thread-Topic: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Thread-Index: AQHZSwIl2lqyJq8SIUKTvkcQR1aWb67joCOA
Date:   Tue, 28 Feb 2023 02:19:39 +0000
Message-ID: <20230228021925.j5bquwnwuvog3hx6@synopsys.com>
References: <20230227232035.13759-1-quic_wcheng@quicinc.com>
In-Reply-To: <20230227232035.13759-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|CH0PR12MB5122:EE_
x-ms-office365-filtering-correlation-id: 213a4b57-bcc7-46d3-aa88-08db19323ed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iTy4e+iJuqi+mtGrfQMPM9EDWu47lKMBpf/TL4Wr7dy9UXbn3FKAI7EaaJGBWlyOJK86fm1P1LXGJeAJVuOnXJIiF/+jKMIcWFJxYZ7UzuecBQeWLXBUv6qEsyrajIGCdDqUKoVG0So4+8ce+iHeq7Yo4o5arAAFTonjlV4RUPaWnqZAJkGyQ5PMNsDgvXEHWH+LUYU8GUasIvVmKIGnrc/yZgmaRclNgPXWwSaxdn3BVPuu8Vamj/l2JzFJ49pHBDQt/PLOYtg2f9+YK9cuh7TFX7oLC+elKnIt3DihpzfLUHJzVheoxyRc7wJX5OXEya8S4hMDlYoeuj/wpJ5uJOe6XvUuTHO8wPco9vtfcqALj0kPnH1j90rFUPV6RPRdX+kzegexGVfS85olfD/hzf6loOe8kyxSmMp0pnP43Rm6lygunGG7kuL5zrYI0B/0MIpOf3cHwkxkfbLnmau6MtWlt2yIwlnT1uVaSL8fmihF15qlXfqpYi5kMyEqUJYMWj801yP6kj7tbcT74IJg496V66K14FjduQKDdZRBnpY99Vvg83m1UfyFYHfXfXdjZDcS3Vhv8sRzr3YWB3j7YJnPjEROH+YiHOvfHbGZe2Jkpv4jGAZH33xCS6hkSMsfJjjvtM26m/8JfhbjSgrYlOeGHjPAy8aHpp3Ny9tfe15jIOREr30tQAMCUt8XaewM7ltLWXzANhWoXogFOwfPMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199018)(8936002)(36756003)(5660300002)(1076003)(6506007)(38100700002)(122000001)(6512007)(26005)(83380400001)(2616005)(186003)(86362001)(6916009)(8676002)(316002)(41300700001)(66946007)(64756008)(91956017)(66556008)(66476007)(54906003)(4326008)(66446008)(478600001)(71200400001)(6486002)(38070700005)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnZaUGFvOVg4bC8ySUt2K3kzTmtXZ1NLN1puQU8wMUh5NUdKSXF1NVB2RnlB?=
 =?utf-8?B?dW9mRU9Yc0JQM0lIUU9sRlZFbWNpbGZuRXcwMmhnaTJacUlndlNuSFYvZGpy?=
 =?utf-8?B?WTBjNUNQaVVOZDV6YWpCWjNDcUFsUWc5eS9RV3JhdFlVRzJhb0dWUTFncS9m?=
 =?utf-8?B?Vkhma1ZEd1puMjNVd1owQ3Y4RDNPSjdXUVUzUlZLdzNtUE9CcmVicm5KMWwv?=
 =?utf-8?B?NTFzVVJjTTBHbWJJN2pBcHZrS0JpS2RvTGhxUWlvL2ExajZqQUlDSXBBVFU2?=
 =?utf-8?B?R3BRYlh3bCtsb2lYcVNmd0ZsVDhnRk1vVlhhcnNIUlU4anhLN2d5TWhSZytN?=
 =?utf-8?B?bVBIQVpyZFgwblZaVmJlb1FYbXc5TFVPbWY4YUpyVXlVd0lIcXQ3bEpmSXZG?=
 =?utf-8?B?VEhYbE45bzFaOVcreUtzbFRHOUxvNjhlcG5Lb0Qvdno1enlqNXZQS3gra20y?=
 =?utf-8?B?SWtVSkpCU2RwTUZoK3BZOUl6dGN3WU1TQnVmSTRqQ1ExcEVQZ0FkdHErTUh1?=
 =?utf-8?B?Vm9lSURyWFIvMG5qM3JrZk03UGYvT1gyT3Z2MW9zNFVyMmh0ekxrdUE1UUxE?=
 =?utf-8?B?N3l0TTRWbm5LY21KS09TbXRWOVV2aklCNGNFZEROenRWS3BKclN6TmNOR2FC?=
 =?utf-8?B?d3FNMC83OGNlYklMYXJ0aVdyeUZVLzEvT0ZMZ1N6c3Z4Y2dtMGJhVUFQdmY3?=
 =?utf-8?B?RjQ1cGpacUErSXE1TGgwdENGbS9tWDBKUWloeHZpZHQ0OE1RNWtuSW1BYWdS?=
 =?utf-8?B?clpZY2xwZkpiVXRmNW5hL3VVL0RtQ0N1VURkT2lnTjF6UjBxOHVFNXAzcjZF?=
 =?utf-8?B?ZWdvaGE5eE1EV0M3NXdyQ05Hc05mU0pOMTRKVHhyaCsrcDUzbUJjMEpIVHFM?=
 =?utf-8?B?RkVSQXVkQmlsNlhUektZOWI5c05wMVBmUStPZFpaeVdPR1M1bm9UWUY1bFll?=
 =?utf-8?B?WXpxdDFOOTY1c3ErMlkrY28xd2NmOEVpM3ZJUDEyWnUwU0NFWXFQZ056VEpE?=
 =?utf-8?B?UnNDSFI1cCtXbS95bUJXYUJZbXpBUTFzZTN5dVJ6VkgxME52L0lnc1ZQSXox?=
 =?utf-8?B?MUpjTkt5bnZ4K1ZPQkQyTlc3aVJxM2pCZ1FlZUc5OTFQOUhJaER6c1I2cGFi?=
 =?utf-8?B?aEtVWk82NXF1aW8vMmNNSUdTTGpidzVSTyt4U1FNNmxYaG5kUjNvNUhBTGdW?=
 =?utf-8?B?UGRSKzNsUFB5Q3ZhbzUzOWsxc0h5ZEV0OHcyWmlrUVNpY2pBMkozL25SSnhn?=
 =?utf-8?B?Uk5UUzlWUFVuaVdWSE15WHo1ZWh3S3ZremM5ODR3SmVrWG4xK3BZbW55V0lC?=
 =?utf-8?B?R00ySXJjeDNONW1kUmc5enZHNlNLZzNoZXRwMkRPVlNseDlnb0I3OEJOTXRS?=
 =?utf-8?B?V1dyRlJhMEJWQlFCbmZ5bGRwN3RNd1hWL1VPMUFoZENhN3pyMHdpZHdQaURX?=
 =?utf-8?B?ZjFTcEcrOWVUSzB3U1U4WnpHVWdyc3JHWjU4a05ua0F4WXJNMkpoWXg5Y1hU?=
 =?utf-8?B?MXpLR0V2ZlBKbGEyUTdOLytPMTJHTkd0aFllby9ucVBCQUovWmV2eWxBaDZK?=
 =?utf-8?B?TUdRNmVyNVJCTFZSYVVHc0w5d3cyclBDbm93SkFYQ00wVUlGSCtkaWZ3Zk5V?=
 =?utf-8?B?OWQ5MnhkTmh4WlhlcUpqc1J3R2RmNXVrRk9oTXQ3ZUVlNVNxc1FaSlptTkd1?=
 =?utf-8?B?cHdYNzJHMFBnaXlKeEQyd21zL0NPT0tOTHlFTlJTSU9ycTVxMTFFYmZ2Wno3?=
 =?utf-8?B?MndmWStEZFFsaGtiZ0V0R3llK0tCNER4SW4ydWlqZGlNNnlISGhmZFJKaGpZ?=
 =?utf-8?B?T3hhUTE0dXVWUGw5QWpGaEJ2YjgrRUpZOHZ2bWN2L0RQL3Z2eXVIRHhXQUIx?=
 =?utf-8?B?Z1JPaTg2UUptNzdkcmh0bFgxSzVmMDl1VUFPN1lvcW9rNUZ5MjU5YzRabFA3?=
 =?utf-8?B?NVVYM0lKZk5YUWxVV05FRTJiOUhRUEwzL0JXeHNxRVE4b0dBaFVmRXhRYVRF?=
 =?utf-8?B?RzZDOTFDWDFnZHdiNmI0bE9ESVBjQnB3YUk3YVlnMnRRNGtRZ0o2M2tWSEJz?=
 =?utf-8?B?ek1vQjNYN0RaSWluZEk0eXlSUXRHMkxWUURtWGNKejV0dERpQUdKVExVWjF0?=
 =?utf-8?Q?xdJ0GQZ4qXfERgkLl5e5NpVMt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C07D808BF1F734AA8C4EF0F9E3AE6AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D/q2Feypb/JGLNJTk/GqLbUT74uDt4PRuCacgljM+MdlpRTKBlP4dft2DKqAofOY+qGykGvdznlQySd/hbVQ0Tt33LJlGp+ciw+fxEieRB76kScV86okhsIgnoriMjC9yCdcUWxUvoFqPLb2kUn5wWg1hX7Z0gXHH4OSssKIaNJZRy2MN1/S2WBL169+m55oe+A56BUxlzsAaFGYWRiZvxD0PKwy6J1/opt+0PBECsUyTa4Tc0ByFboYU8a7afZAL1nvqL10eRHhXRP2TyoidUsFeLeiZfuQrUIjDa+HBll4CPDo8GnFk6MSdPR6aGr+4VQ7pnenU6hOkIKFFa7VF0xX6znJv5faCwInH0DctRcholeinHnQdDtiNK+Xa4fX9d2S8jDmgIKNrSeQVDawaea4BME7Pn7xDTjPpLD+NJTG2xQ1cQuyJGf/lCwUZAPR+LMQrl9zXBHGdw/K3/ewTQDjaX+s4G8ZDkDTjKyPpF615VFgZfzEa8SKKl9viuGh1leg2TSBBlxJeKBph8nVO2HnwCb+nwMjyAXh7RwSQUj6k6ZrA9Cc7R3JouynnOKyx9RzTxozbeB7lRZ4ve3jtUtV83J15Ie2GdnM/5SDOS3C/Zdbra9rf6DQZSqIICH+QrrrHqkMmjuPm6P72/Sc89FO9rKbtkgjVA4gg1e4cG2yqc06fH62u8DOvnlZ7ag0ZytLj8A5F/nvCyAT4ZY7il6NkDqYEEcTOHyMO6zE5fa+1MD+9ED3tdKBiCfN8DlobRfwlQwxQ3iC7a9Y+sdRIwS77Uhguwz0pVG2azxcg7EyOtyy/NJ0LdZrNfG/b9EHShTWQKY9ygE+V8zBWGrbT9klgXt5l2J4JxoM7Ja7m+fPuvIlmkKR8czRZWlu+eb37a+dXbfXUQWvGDcdTtWYHg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213a4b57-bcc7-46d3-aa88-08db19323ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 02:19:39.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoqTQJG/ZEhSusKVMr7iEG6sTWEfwjz2YFoTxynH+h3RgbeMjWNkegSf39YbT7YEAnyAL3yzZ1FqqreuHQL98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
X-Proofpoint-GUID: 7-juIH2dw2tfSwPLRjizPhTIVIDIBUUv
X-Proofpoint-ORIG-GUID: 7-juIH2dw2tfSwPLRjizPhTIVIDIBUUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_19,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=774
 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302280014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMjcsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gUHJldmlvdXNseSwg
dGhlcmUgd2FzIGEgMTAwdVMgZGVsYXkgaW5zZXJ0ZWQgYWZ0ZXIgaXNzdWluZyBhbiBlbmQgdHJh
bnNmZXINCj4gY29tbWFuZCBmb3Igc3BlY2lmaWMgY29udHJvbGxlciByZXZpc2lvbnMuICBUaGlz
IHdhcyBkdWUgdG8gdGhlIGZhY3QgdGhhdA0KPiB0aGVyZSB3YXMgYSBHVUNUTDIgYml0IGZpZWxk
IHdoaWNoIGVuYWJsZWQgc3luY2hyb25vdXMgY29tcGxldGlvbiBvZiB0aGUNCj4gZW5kIHRyYW5z
ZmVyIGNvbW1hbmQgb25jZSB0aGUgQ01EQUNUIGJpdCB3YXMgY2xlYXJlZCBpbiB0aGUgREVQQ01E
DQo+IHJlZ2lzdGVyLiAgU2luY2UgdGhpcyBiaXQgZG9lcyBub3QgZXhpc3QgZm9yIGFsbCBjb250
cm9sbGVyIHJldmlzaW9ucywgYWRkDQo+IHRoZSBkZWxheSBiYWNrIGluLg0KPiANCj4gQW4gaXNz
dWUgd2FzIHNlZW4gd2hlcmUgdGhlIFVTQiByZXF1ZXN0IGJ1ZmZlciB3YXMgdW5tYXBwZWQgd2hp
bGUgdGhlIERXQzMNCj4gY29udHJvbGxlciB3YXMgc3RpbGwgYWNjZXNzaW5nIHRoZSBUUkIuICBI
b3dldmVyLCBpdCB3YXMgY29uZmlybWVkIHRoYXQgdGhlDQo+IGVuZCB0cmFuc2ZlciBjb21tYW5k
IHdhcyBzdWNjZXNzZnVsbHkgc3VibWl0dGVkLiAobm8gZW5kIHRyYW5zZmVyIHRpbWVvdXQpDQoN
CkN1cnJlbnRseSB3ZSBvbmx5IGNoZWNrIGZvciBjb21tYW5kIGFjdGl2ZSwgbm90IGNvbXBsZXRp
b24gb24gdGVhcmRvd24uDQoNCj4gSW4gc2l0dWF0aW9ucywgc3VjaCBhcyBkd2MzX2dhZGdldF9z
b2Z0X2Rpc2Nvbm5lY3QoKSBhbmQNCj4gX19kd2MzX2dhZGdldF9lcF9kaXNhYmxlKCksIHRoZSBk
d2MzX3JlbW92ZV9yZXF1ZXN0KCkgaXMgdXRpbGl6ZWQsIHdoaWNoDQo+IHdpbGwgaXNzdWUgdGhl
IGVuZCB0cmFuc2ZlciBjb21tYW5kLCBhbmQgZm9sbG93IHVwIHdpdGgNCj4gZHdjM19nYWRnZXRf
Z2l2ZWJhY2soKS4gIEF0IGxlYXN0IGZvciB0aGUgVVNCIGVwIGRpc2FibGUgcGF0aCwgaXQgaXMN
Cj4gcmVxdWlyZWQgZm9yIGFueSBwZW5kaW5nIGFuZCBzdGFydGVkIHJlcXVlc3RzIHRvIGJlIGNv
bXBsZXRlZCBhbmQgcmV0dXJuZWQNCj4gdG8gdGhlIGZ1bmN0aW9uIGRyaXZlciBpbiB0aGUgc2Ft
ZSBjb250ZXh0IG9mIHRoZSBkaXNhYmxlIGNhbGwuICBXaXRob3V0DQo+IHRoZSBHVUNUTDIgYml0
LCBpdCBpcyBub3QgZW5zdXJlZCB0aGF0IHRoZSBlbmQgdHJhbnNmZXIgaXMgY29tcGxldGVkIGJl
Zm9yZQ0KPiB0aGUgYnVmZmVycyBhcmUgdW5tYXBwZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBX
ZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KDQpUaGlzIGlzIGV4cGVjdGVk
LiBXZSdyZSBzdXBwb3NlZCB0byBtYWtlIHN1cmUgdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kDQpj
b21wbGV0ZSBiZWZvcmUgYWNjZXNzaW5nIHRoZSByZXF1ZXN0LiBVc3VhbGx5IG9uIGRldmljZS9l
bmRwb2ludA0KdGVhcmRvd24sIHRoZSBnYWRnZXQgZHJpdmVycyBkb24ndCBhY2Nlc3MgdGhlIHN0
YWxlL2luY29tcGxldGUgcmVxdWVzdHMNCndpdGggLUVTSFVURE9XTiBzdGF0dXMuIFRoZXJlIHdp
bGwgYmUgcHJvYmxlbXMgaWYgd2UgZG8sIGFuZCB3ZSBoYXZlbid0DQpmaXhlZCB0aGF0Lg0KDQpB
ZGRpbmcgMTAwdVMgbWF5IG5vdCBhcHBseSBmb3IgZXZlcnkgZGV2aWNlLCBhbmQgd2UgZG9uJ3Qg
bmVlZCB0byBkbw0KdGhhdCBmb3IgZXZlcnkgRW5kIFRyYW5zZmVyIGNvbW1hbmQuIENhbiB5b3Ug
dHJ5IHRoaXMgdW50ZXN0ZWQgZGlmZg0KaW5zdGVhZDoNCg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCmluZGV4IDMw
NDA4YmFmZTY0ZS4uNWFlNWZmNGM4ODU4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KQEAgLTE5NjIsNiArMTk2
MiwzNCBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKHN0cnVjdCBkd2MzICpk
d2MpDQogCXJldHVybiBEV0MzX0RTVFNfU09GRk4ocmVnKTsNCiB9DQogDQorc3RhdGljIGludCBk
d2MzX3BvbGxfZXBfY29tcGxldGlvbihzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KK3sNCisJaWYgKCFs
aXN0X2VtcHR5KCZkZXAtPnN0YXJ0ZWRfbGlzdCkpIHsNCisJCXN0cnVjdCBkd2MzX3JlcXVlc3Qg
KnJlcTsNCisJCWludCB0aW1lb3V0ID0gNTAwOw0KKw0KKwkJcmVxID0gbmV4dF9yZXF1ZXN0KCZk
ZXAtPnN0YXJ0ZWRfbGlzdCk7DQorCQl3aGlsZSgtLXRpbWVvdXQpIHsNCisJCQkvKg0KKwkJCSAq
IE5vdGU6IGRvbid0IGNoZWNrIHRoZSBsYXN0IGVucXVldWVkIFRSQiBpbiBjYXNlDQorCQkJICog
b2Ygc2hvcnQgdHJhbnNmZXIuIENoZWNrIGZpcnN0IFRSQiBvZiBhIHN0YXJ0ZWQNCisJCQkgKiBy
ZXF1ZXN0IGluc3RlYWQuDQorCQkJICovDQorCQkJaWYgKCEocmVxLT50cmItPmN0cmwgJiBEV0Mz
X1RSQl9DVFJMX0hXTykpDQorCQkJCWJyZWFrOw0KKw0KKwkJCXVkZWxheSgyKTsNCisJCX0NCisJ
CWlmICghdGltZW91dCkgew0KKwkJCWRldl93YXJuKGRlcC0+ZHdjLT5kZXYsDQorCQkJCSAiJXMg
aXMgc3RpbGwgaW4tcHJvZ3Jlc3NcbiIsIGRlcC0+bmFtZSk7DQorCQkJcmV0dXJuIC1FVElNRURP
VVQ7DQorCQl9DQorCX0NCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KIC8qKg0KICAqIF9fZHdjM19z
dG9wX2FjdGl2ZV90cmFuc2ZlciAtIHN0b3AgdGhlIGN1cnJlbnQgYWN0aXZlIHRyYW5zZmVyDQog
ICogQGRlcDogaXNvYyBlbmRwb2ludA0KQEAgLTIwMDMsMTAgKzIwMzEsMTIgQEAgc3RhdGljIGlu
dCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBm
b3JjZSwgYm9vbCBpbnQNCiAJV0FSTl9PTl9PTkNFKHJldCk7DQogCWRlcC0+cmVzb3VyY2VfaW5k
ZXggPSAwOw0KIA0KLQlpZiAoIWludGVycnVwdCkNCisJaWYgKCFpbnRlcnJ1cHQpIHsNCisJCXJl
dCA9IGR3YzNfcG9sbF9lcF9jb21wbGV0aW9uKGRlcCk7DQogCQlkZXAtPmZsYWdzICY9IH5EV0Mz
X0VQX1RSQU5TRkVSX1NUQVJURUQ7DQotCWVsc2UgaWYgKCFyZXQpDQorCX0gZWxzZSBpZiAoIXJl
dCkgew0KIAkJZGVwLT5mbGFncyB8PSBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HOw0KKwl9
DQogDQogCWRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfREVMQVlfU1RPUDsNCiAJcmV0dXJuIHJldDsN
Cg0KDQpUaGFua3MsDQpUaGluaA==
