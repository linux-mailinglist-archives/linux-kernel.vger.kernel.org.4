Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1660D6B82B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCMU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCMU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:27:49 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D048C529;
        Mon, 13 Mar 2023 13:27:20 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DK7nhU028906;
        Mon, 13 Mar 2023 13:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=+Y5oAPSL3tlRjckB1uJ658wRzZPJ3oA6wM/Bo4uw6cg=;
 b=WcIDu1FXZcpRCQIvpRNa7UOFwo8qYTNn8CBIKA4UNWeAUdK1J6WTG2mDvefnt0pnVTfr
 eTDM2we0sH9XzN8unrdzJwnaq5fECaT9d+ay/gj012rdgBPmrkL6yClAptXHikXNG8ai
 nqjamPAlzitJB6ZGCv0UYe06JEcT2hELKb9Rp/Tp3U32ogz+yzA/Y2nqWvpSW+1pNM2o
 4rdnTIWZrNFlktBQdnMSwVWV5KHwqjBwFA9Xs1FwhqD+mHW8UV4QMW+5ND5IeS7Fs2N9
 UO7xyUzKLWbu5Yl1s8ZMB8cksdl3kxswAmxYRNz1q70l0OCA50lYAiCxNObF7Dk7frG/ kg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p9a23evk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 13:27:07 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8FCB240103;
        Mon, 13 Mar 2023 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678739225; bh=+Y5oAPSL3tlRjckB1uJ658wRzZPJ3oA6wM/Bo4uw6cg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=F/fSGtNo106k9kek71NErAQvBOf7o0ODh4ftOfbQ2oyQFuic48pNuo8NltXffPN6T
         kzi19xKad2mqDlUrN2KLjGNfkLXUEVLAsnEceaAQcJDYtjSntifTBBshVOvIK9dspf
         SfRFLcBWxuOGmUg/dDaaMoupP9Is9me98w4NdLAUmkoMdna1Xx46zzv5nj5ZAtu4sw
         6VNnvM/Ym68zVbfHQv3Ez91yfxjBPhV4klIv7GPWz16GGPwRejqbLXU+86bIRPtYGs
         pP1E+1QrUSnKEHYu0k/mZ1VnCIHb00b+TVb44fcGWdRWUZhRO6avL6/LhGKRRSYRRf
         KdY+cQ6ojjIdg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DE2B2A006D;
        Mon, 13 Mar 2023 20:27:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B330440084;
        Mon, 13 Mar 2023 20:27:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="iTiiBrNp";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4BOGDAAkMhI9syB4y1QxVE0ijNVNqgRZQ+4cmoNttUvxvLQq2+8HDNtXU7Gs5NDUI6hlX99Y/YNImGWRcQBkZAhYl88zLyPFrH+dPJfUVCPonVHE57KHBo/8aUZ73qvbzOsPYVfyieFEWK4s32tNfUEB2sChDcGW6KTutR0uqU3B0AnlFVTLABziuWIlIGZuH6e+sivEgHyIT1SBTt6hIek17OZWT6fq+GMn/r0o4oR/SMgKRjAjn5yWHEwkGkM56yaruEfTm/h6S+2a/O0g6IEymWPf99qbtxukbSabnDL9WJu2tHIsrg1XISKjblvaBEK8hxQrrieeEFGLVG5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y5oAPSL3tlRjckB1uJ658wRzZPJ3oA6wM/Bo4uw6cg=;
 b=RVW2vl1NzCf+VPA6/EDe7ywsXq96d1Lo4Ixa1cmB+/XrsSkK9PfykceAiHmfHMJdHFC+q8yZ5Q0jEr4EzMdzj+cnJei9gyyyA2fkdMY34EtvtdtMsMB4RFZlKrRXgjFcbOWG1Zz/PBD5n67g8MuQctpoDTH1uzOYa42aMJbN8oQY0UQxwSklTnXlf/gbgz7sMwzVyoBvLlHHg3iJc5EQni7ujJUQtypL2j/2/wkZIjv0eCEY+7YG6m2pZomOun5ju+CD96XWTZEdXWJtVFINLQw5vZk6lX9Vz7j6FK0+gFRYBfZuoPUGXdbUFBrnfjM+TTCIuUkzhr5SmAZI/YNTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y5oAPSL3tlRjckB1uJ658wRzZPJ3oA6wM/Bo4uw6cg=;
 b=iTiiBrNpGs5rgmFD7Twe3PTlVd9w4ySCGjy0OfsxMVERL6cAfANgC86BvIj6Kj8roCzGxrlC41qbi0dqCoIO1+UBihKTGpfntSfV7rXy4ApI2YpscrwQkOhNhsterHst8Lzq+EA5TWpOt0L+hYF4XubQi4H+xL4J3d6TFDa/giU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Mon, 13 Mar
 2023 20:27:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 20:27:00 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v8 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v8 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Index: AQHZVdkm2qliMtpSnkaUilVaMBFAZa75KJuA
Date:   Mon, 13 Mar 2023 20:27:00 +0000
Message-ID: <20230313202655.srqfddpn5r36zt3o@synopsys.com>
References: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
 <1678731892-20503-6-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678731892-20503-6-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB6930:EE_
x-ms-office365-filtering-correlation-id: 6732b036-2885-41fc-f153-08db24014cc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t7IZmLjXSYxa7JOSxTLoJPqDBEy4PR411rAceLkW0J362u5AsbC8e2mfuMAObgqBxNt6RcE8O5hjsEIJ8JQzLbskeen80TYfX4cQb5jSDZRC/mKtQ7jJkWvQHTRl5vi5o4dqk6IJ90MsLQ+9JO+iOYeeNmbjhrF55C90Ci0wOpWdwGt2kAYynI4CL5T17aRVqCP8+V8iUXlt58Cj3hLBsptFP5htu7zmmd+q9DwN/YcxHnAAkies1U5Jb3lR4QRayn7qbPFGCtO2FeTucWKhT/4RN1PV9EBny4iPtrixlRt6uTLbIH++WNfcV+MX3//EC9QNQK5DIx9yYes0k3P6PJb43G1I0XECk53qg2bYj61eBqZb02W1Z1qG/q4NeJ/cv2ILyr4noWxeei2vFrQUruDCvTd+ds5RAvWAZjHoVEXGrHJxW1wsRQxTAyIDBexmYWP0Mui5HdFJhAmRbHTv/24l0gpaFC/wnf+CtJKRcsfLxqzP4J+x0G+eBh1WkameOSbUYWuRcnCmSVtKbvoG+jIoOfmvpD44GJsURmy9zLUjldxh9N3/qpqY2MJzU2NA1rlpU6yLtbTayWL1MIqXjNyECK+wvZW3kYTTrducteu64AAQR2WaZvagL1vsgZbmvQNWrYaGB5uX5EcdkQFBaWVE+2x4UUsZ3XZ5hkYADO59Sz8onWsCI9ryC6ws0TL1D8UQLXRKYu2+AxlVA3zlng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199018)(83380400001)(36756003)(478600001)(122000001)(38070700005)(316002)(54906003)(38100700002)(5660300002)(15650500001)(6486002)(186003)(6506007)(6512007)(71200400001)(2616005)(1076003)(64756008)(26005)(8676002)(2906002)(6916009)(8936002)(4326008)(66446008)(66476007)(66946007)(41300700001)(66556008)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUpSUlBuTWlpOWJoazd1aFA1OUNPcWdOM3hURUdocHZISk5jZDJqdVU5S0Z5?=
 =?utf-8?B?YVRwam9PNjRIRzlTbHlodzdDeWdJeDN5UHIyU0dPVGYvSVZXdjBnbE81M1JD?=
 =?utf-8?B?YndnaHVOVWw1MDZPdGl5R0FYVFRsdEpDMXI3TmQ3dGFROHFjY1FqdXhRd05q?=
 =?utf-8?B?TE5QK3Y4Lzh4NkFiUzhTWnJjOTBvZGtsUDJHc2VBRElCcU1hVUtNTnNIaFB4?=
 =?utf-8?B?MGtoSjJXU2dHdFRQcVBvWXNtOVJya0U2Zk16K1ZLKzdZMkdMN1VOc2FaaDFL?=
 =?utf-8?B?WWJabDJOT3hWd1BhdjF4Smp2RDIwUENVd00ycTVhdGxRUkFHTWZjMWZHek9a?=
 =?utf-8?B?dmc0Yyt6SGdTNmMyQlA0NlVxUjB4SnVlZHhvWVo2eE1ZakUwZUw0blRKS0dH?=
 =?utf-8?B?NENvbmlvSk1KaXJrMXF6NFQxbStJdE9jRmVLSUdJeWR2T3FvelRJdXVaMC8w?=
 =?utf-8?B?Q0ZGWGVkVDlBNEYySGk1aVlRYXFmUlNWT2FUNnpVRWk2R0FGWVdwRkI5bjhD?=
 =?utf-8?B?YkJ5S2dKeGZlRVg1ajZlNnZQelQ1eTVCZ2ZNMG40b1B5U2xPeTZ2d3phTktx?=
 =?utf-8?B?eGR1aHJNTnhiRGxhcG9yNTJzangrNFNPQjZrZmhCT2tzdnZGait5cHZQbnFi?=
 =?utf-8?B?MWVvSm1BTVpZUnZleU4wVFdKTkFVNGpKTys3endQOUhmQmVSNTNSdEE2UmRj?=
 =?utf-8?B?NmIyT0w4dUVRdXZKcGxOcWM2eTFjeGVSMWg5TEptYVJNVWZtYlY1alo2NGF3?=
 =?utf-8?B?NmEwVFJBVUxJYWZqUkR3cXhXaTZxL2tJa1BTVjhIK21PdEJTbTAzYnBoQ0k3?=
 =?utf-8?B?TkdlWnV6UmdyalAzZnYwWXdJWFgrcENCK0k4Z1c2NWZxY0l3MExGdkRWT0sr?=
 =?utf-8?B?MHZheXVNYXJUaHM2TVBzMVRmQ1l4WG5PNGZORlJrZmg3ZGNudkxCdlIrYTl6?=
 =?utf-8?B?NkorMTVJbnljelZySXhrc1ExWnBIUzdCNGxHd2FzR1FETVpKRW85Rk5obktj?=
 =?utf-8?B?UmxYalJtaHZsT3NTVzEvK29kVFVxcUhvQnV6clNQd3JVa1RwOVBjaEh3S3RK?=
 =?utf-8?B?ak55K2RrVk1nSDA4MGRuQ1FpMEh1ZFVqL2ZpRTI4dUdRZ0VudjZVTG5xcytH?=
 =?utf-8?B?UERYME1ZdlkxZ3FGU1lSWjdyZ1Z5ZWZDS0F5SkJsVjF2VUR4Qk1uYi9RV0R4?=
 =?utf-8?B?RXM0bUJIMmJwUkNjUDhJWDBReGxLdDZldWxwWThIMHhHaTlJeWlJeFNDbXR0?=
 =?utf-8?B?U0E0ckttMzF2RUtnNVFwSTJXTWFNUlVWRjJzTHBpRk4yY3BoM2xJUWlKTjQv?=
 =?utf-8?B?RzRaVDlsWTJOczZnRzUyRTc2SFp3c1M3UXhYOFVPamhtRXBRVnhNS0F6N0dJ?=
 =?utf-8?B?VmlhYm9haWt0ekRMWDlqR3ZIUDdzelZNa21TRWZOMTRTUFJ4ay83VHVzTnV0?=
 =?utf-8?B?UklUNEFnQjhvMXdlUFpwbzBJeTVXVTVhOWtjS2QvY1lzOGZlc3ZrK0FTREJY?=
 =?utf-8?B?MXFlci9GaTVqL3pEay9TMTJIN1dhNFByajVJNUU3NVUwemRZanVqeENMWERQ?=
 =?utf-8?B?TmtwZTdaemtXV2RDUlFGT1A5UFRGd0doUWVFOUo4MklnaFRCVXJPTTBZTkhs?=
 =?utf-8?B?MWZRYTVLbkQ2YWRRVUdscEpXZXFhc1BEUGdoSVVsSkFGcktKVE8zTFVPamkr?=
 =?utf-8?B?STVKVHFOdytQZDRodDc3Rkt0T1VJYi9BOGF6RTEzSGkrYjhJMW1lNFc4L3c2?=
 =?utf-8?B?UkVobDNtTnNnem16elRZV21lOUI1ZHh6b0tWcjlHZTBPWFlNUTZ2NTVJSDda?=
 =?utf-8?B?aUVRang3ekJNOVFrbDB3L2JvNHpRWjdGVmdId0l6UzRCcmxJdzhQTkVPZkRT?=
 =?utf-8?B?STM5OWdXQ0RGc3VoS3RwcFY2Z0p1blYzVjFHdVIxcGY4SHUycE9tZVZVck9Y?=
 =?utf-8?B?ZndvU0lNRDNYbG95VFk3L3FHTHF0S3pEWXd0YWVaaTl1WFdvck5kbE1NQ2hK?=
 =?utf-8?B?RVNaL0k0cnd3NXZWck8zVnFIQXE4QlB3Zk9hZkMxMWd3Y2R3MlZqSFBpS2l4?=
 =?utf-8?B?dkFDcjVOR1pDS3d1aDlBZmV1aWlVUXlsZW9NczNEM0QrOFJNRFJvNGM5em9C?=
 =?utf-8?Q?Qw1DVSLTkwwdumkNyo0HWBFLo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCBA6EBA535E8141A5317D869261C2AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b85btpShHp1jtmDkKip+7aebRHBcWv1NiyyJz3Yg5HaBREwgFXY1ocgzjnzgC3LvKYGDPp/10KMfSgbzijsi7YF+0Kx5J57rc1ux/L8NrMUlFCOZ/sFg9To7/tsZykxyYSHHK/BCHXI/Gcq+gca8vBol2FDXtYT28rUomhs+Rs1/8P63smh9akXbiNd5TY9MGICiGsYwnzW8KVPT83AbUUa92rb7ZwUtV0YJZwmx2W51Ez5dHejmCRCk1Q+C7wl7+yA9Zcv9Hw5+JAZgKNlvj015B4ULeyGxLPxXZM0H9VuGphYrHfZjKXlyu1hlQ5heY/qlrD9GjaovRj/H4yiBMJy3lWhCJItEQFqkkfSOLxNXSqHVGAS2civkj9ahsIQADzhy1TrB4lw892Kiv59HCzo9hq1+5O7s3gE/kSyUqaCeyvB+OigxUTtALazwkm8uxr3ebJ4/gLoI6X7XybrCORW6Vs98upn4+kQDU03bpi6+HpyaY57FUvjzsd+eRlkvb/gwOnKqxBVgGriRdqL43MaryANgV8vRkO8xXwjSmFJ21VOv0fiiIx4+iDAOuy0FH2IGIDEIbynFFnsUUyV3aegXHVFqIvRJ2+8Sl7xOqwZxpW1AS0pWrU63vzj+BNomq/DVrZ/EgVFma4z5MNIkBpMZ11FN4J4VFhnrIstQMTYbR0qq3sF5rG1lzxvZb3XsLvShd44ygpruCedIOFsudWupQCptyOqz4f+tjFs00PJ30UUh0o32I3D/wBovgCtZYtjwZ+2CmXrsKX4YDNNZDpPnh7Z41PkbeU9A+xyz8U+CuTyimCZajl+wlnItlR7XR9dJ0BJUgyMoHuq1WsxzmuLpRfvbtb2QLPxtJjksliGWmN41GbVuS/TBBHS6/2Dom2Y+CW+O7GvevyILyNqGqITTHtredSL1/ib/YQZiLwQ=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6732b036-2885-41fc-f153-08db24014cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 20:27:00.3712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIOBwn2/r0sFnH905SNKBHpbCMa5tC1uGN40bbx+81/sd7G8uEP+z70H6BsqnpIQGpz0fwtPFiUkxReA+OdQBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
X-Proofpoint-GUID: 9EOY54vfkTAlTUaiyDG3hJwbMwF1zNRa
X-Proofpoint-ORIG-GUID: 9EOY54vfkTAlTUaiyDG3hJwbMwF1zNRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_10,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303130160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXIgMTMsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFdoZW4gaG9z
dCBzZW5kcyBhIHN1c3BlbmQgbm90aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UsIGhhbmRsZQ0KPiB0
aGUgc3VzcGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3Vw
ZXINCj4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUg
dG8gcHV0IHRoZQ0KPiBmdW5jdGlvbiBpbiBzdXNwZW5kIHN0YXRlLiBIYW5kbGUgZnVuY3Rpb24g
c3VzcGVuZCBjYWxsYmFjay4NCj4gDQo+IERlcGVuZGluZyBvbiB0aGUgcmVtb3RlIHdha2V1cCBj
YXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiB0cmlnZ2VyIGEgcmVtb3RlIHdha2V1
cCBvciB3YWl0IGZvciB0aGUgaG9zdCBpbml0aWF0ZWQgcmVzdW1lIHRvDQo+IHN0YXJ0IGRhdGEg
dHJhbnNmZXIgYWdhaW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxx
dWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfZWNtLmMgICB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jIHwgNjMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X2V0aGVyLmggfCAgNCArKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTM1IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYyBi
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+IGluZGV4IGE3YWIzMGUuLmQ1
MGMxYTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+IEBAIC02MzMs
NiArNjMzLDggQEAgc3RhdGljIHZvaWQgZWNtX2Rpc2FibGUoc3RydWN0IHVzYl9mdW5jdGlvbiAq
ZikNCj4gIA0KPiAgCXVzYl9lcF9kaXNhYmxlKGVjbS0+bm90aWZ5KTsNCj4gIAllY20tPm5vdGlm
eS0+ZGVzYyA9IE5VTEw7DQo+ICsJZi0+ZnVuY19zdXNwZW5kZWQgPSBmYWxzZTsNCj4gKwlmLT5m
dW5jX3dha2V1cF9hcm1lZCA9IGZhbHNlOw0KPiAgfQ0KPiAgDQo+ICAvKi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0qLw0KPiBAQCAtODg1LDYgKzg4Nyw2OCBAQCBzdGF0aWMgc3RydWN0IHVzYl9mdW5jdGlvbl9p
bnN0YW5jZSAqZWNtX2FsbG9jX2luc3Qodm9pZCkNCj4gIAlyZXR1cm4gJm9wdHMtPmZ1bmNfaW5z
dDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZWNtX3N1c3BlbmQoc3RydWN0IHVzYl9mdW5j
dGlvbiAqZikNCj4gK3sNCj4gKwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYpOw0K
PiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZp
Zy0+Y2RldjsNCj4gKw0KPiArCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkgew0KPiArCQlEQkcoY2Rl
diwgIkZ1bmN0aW9uIGFscmVhZHkgc3VzcGVuZGVkXG4iKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0N
Cj4gKw0KPiArCURCRyhjZGV2LCAiRUNNIFN1c3BlbmRcbiIpOw0KPiArDQo+ICsJZ2V0aGVyX3N1
c3BlbmQoJmVjbS0+cG9ydCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGVjbV9yZXN1bWUo
c3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gK3sNCj4gKwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1
bmNfdG9fZWNtKGYpOw0KPiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+
cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsNCj4gKw0KPiArCS8qDQo+ICsJICogSWYgdGhlIGZ1bmN0
aW9uIGlzIGluIFVTQjMgRnVuY3Rpb24gU3VzcGVuZCBzdGF0ZSwgcmVzdW1lIGlzDQo+ICsJICog
Y2FuY2VsZWQuIEluIHRoaXMgY2FzZSByZXN1bWUgaXMgZG9uZSBieSBhIEZ1bmN0aW9uIFJlc3Vt
ZSByZXF1ZXN0Lg0KPiArCSAqLw0KPiArCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkNCj4gKwkJcmV0
dXJuOw0KPiArDQo+ICsJREJHKGNkZXYsICJFQ00gUmVzdW1lXG4iKTsNCj4gKw0KPiArCWdldGhl
cl9yZXN1bWUoJmVjbS0+cG9ydCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZWNtX2dldF9z
dGF0dXMoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gK3sNCj4gKwlyZXR1cm4gKGYtPmZ1bmNf
d2FrZXVwX2FybWVkID8gVVNCX0lOVFJGX1NUQVRfRlVOQ19SVyA6IDApIHwNCj4gKwkJVVNCX0lO
VFJGX1NUQVRfRlVOQ19SV19DQVA7DQoNCk5lZWQgdG8gY2hlY2sgdGhlIHVzYiBjb25maWd1cmF0
aW9uIGlzIGlmIGl0J3Mgd2FrZXVwX2NhcGFibGUuDQoNCj4gK30NCj4gKw0KPiArc3RhdGljIGlu
dCBlY21fZnVuY19zdXNwZW5kKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYsIHU4IG9wdGlvbnMpDQo+
ICt7DQo+ICsJc3RydWN0IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShmKTsNCj4gKwlzdHJ1Y3Qg
dXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBlY20tPnBvcnQuZnVuYy5jb25maWctPmNkZXY7DQo+
ICsNCj4gKwlEQkcoY2RldiwgImZ1bmMgc3VzcCAldSBjbWRcbiIsIG9wdGlvbnMpOw0KPiArDQo+
ICsJZi0+ZnVuY193YWtldXBfYXJtZWQgPSAhIShvcHRpb25zICYgKFVTQl9JTlRSRl9GVU5DX1NV
U1BFTkRfUlcgPj4gOCkpOw0KDQpTYW1lIGhlcmUuIENoZWNrIGNvbmZpZydzIGJtQXR0cmlidXRl
cyBpZiBpdCdzIHJlbW90ZSB3YWtldXAgY2FwYWJsZQ0KYmVmb3JlIGFybWluZyBmb3IgcmVtb3Rl
IHdha2V1cC4NCg0KPiArDQo+ICsJaWYgKG9wdGlvbnMgJiAoVVNCX0lOVFJGX0ZVTkNfU1VTUEVO
RF9MUCA+PiA4KSkgew0KPiArCQlpZiAoIWYtPmZ1bmNfc3VzcGVuZGVkKSB7DQo+ICsJCQllY21f
c3VzcGVuZChmKTsNCj4gKwkJCWYtPmZ1bmNfc3VzcGVuZGVkID0gdHJ1ZTsNCj4gKwkJfQ0KPiAr
CX0gZWxzZSB7DQo+ICsJCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkgew0KPiArCQkJZi0+ZnVuY19z
dXNwZW5kZWQgPSBmYWxzZTsNCj4gKwkJCWVjbV9yZXN1bWUoZik7DQo+ICsJCX0NCj4gKwl9DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCg0KTmVlZCB0byByZXR1cm4gbmVnYXRpdmUgZXJyb3IgaWYgU2V0
RmVhdHVyZSBmYWlscy4gV2Ugc2hvdWxkIGZpeCB0aGUNCmNvbXBvc2l0ZSBsYXllciB0byBhbGxv
dyBmb3IgcHJvdG9jYWwgU1RBTEwgaGVyZS4gSG9zdCBuZWVkcyB0byBrbm93IGlmDQppdCBzaG91
bGQgcHJvY2VlZCB0byBwdXQgdGhlIGZ1bmN0aW9uIGluIHN1c3BlbmQuDQoNClRoYW5rcywNClRo
aW5oDQoNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgZWNtX2ZyZWUoc3RydWN0IHVzYl9mdW5j
dGlvbiAqZikNCj4gIHsNCj4gIAlzdHJ1Y3QgZl9lY20gKmVjbTsNCj4gQEAgLTk1Miw2ICsxMDE2
LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICplY21fYWxsb2Moc3RydWN0IHVzYl9m
dW5jdGlvbl9pbnN0YW5jZSAqZmkpDQo+ICAJZWNtLT5wb3J0LmZ1bmMuc2V0dXAgPSBlY21fc2V0
dXA7DQo+ICAJZWNtLT5wb3J0LmZ1bmMuZGlzYWJsZSA9IGVjbV9kaXNhYmxlOw0KPiAgCWVjbS0+
cG9ydC5mdW5jLmZyZWVfZnVuYyA9IGVjbV9mcmVlOw0KPiArCWVjbS0+cG9ydC5mdW5jLnN1c3Bl
bmQgPSBlY21fc3VzcGVuZDsNCj4gKwllY20tPnBvcnQuZnVuYy5nZXRfc3RhdHVzID0gZWNtX2dl
dF9zdGF0dXM7DQo+ICsJZWNtLT5wb3J0LmZ1bmMuZnVuY19zdXNwZW5kID0gZWNtX2Z1bmNfc3Vz
cGVuZDsNCj4gKwllY20tPnBvcnQuZnVuYy5yZXN1bWUgPSBlY21fcmVzdW1lOw0KPiAgDQo+ICAJ
cmV0dXJuICZlY20tPnBvcnQuZnVuYzsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24v
dV9ldGhlci5jDQo+IGluZGV4IGYyNTk5NzUuLjhlYmEwMTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL3VfZXRoZXIuYw0KPiBAQCAtNDM3LDYgKzQzNywyMCBAQCBzdGF0aWMgaW5s
aW5lIGludCBpc19wcm9taXNjKHUxNiBjZGNfZmlsdGVyKQ0KPiAgCXJldHVybiBjZGNfZmlsdGVy
ICYgVVNCX0NEQ19QQUNLRVRfVFlQRV9QUk9NSVNDVU9VUzsNCj4gIH0NCj4gIA0KPiArc3RhdGlj
IGludCBldGhlcl93YWtldXBfaG9zdChzdHJ1Y3QgZ2V0aGVyICpwb3J0KQ0KPiArew0KPiArCWlu
dAkJCXJldDsNCj4gKwlzdHJ1Y3QgdXNiX2Z1bmN0aW9uCSpmdW5jID0gJnBvcnQtPmZ1bmM7DQo+
ICsJc3RydWN0IHVzYl9nYWRnZXQJKmdhZGdldCA9IGZ1bmMtPmNvbmZpZy0+Y2Rldi0+Z2FkZ2V0
Ow0KPiArDQo+ICsJaWYgKGZ1bmMtPmZ1bmNfc3VzcGVuZGVkKQ0KPiArCQlyZXQgPSB1c2JfZnVu
Y193YWtldXAoZnVuYyk7DQo+ICsJZWxzZQ0KPiArCQlyZXQgPSB1c2JfZ2FkZ2V0X3dha2V1cChn
YWRnZXQpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIG5ldGRl
dl90eF90IGV0aF9zdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsDQo+ICAJCQkJCXN0cnVj
dCBuZXRfZGV2aWNlICpuZXQpDQo+ICB7DQo+IEBAIC00NTYsNiArNDcwLDE1IEBAIHN0YXRpYyBu
ZXRkZXZfdHhfdCBldGhfc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiAgCQlpbiA9
IE5VTEw7DQo+ICAJCWNkY19maWx0ZXIgPSAwOw0KPiAgCX0NCj4gKw0KPiArCWlmIChkZXYtPnBv
cnRfdXNiLT5pc19zdXNwZW5kKSB7DQo+ICsJCURCRyhkZXYsICJQb3J0IHN1c3BlbmRlZC4gVHJp
Z2dlcmluZyB3YWtldXBcbiIpOw0KPiArCQluZXRpZl9zdG9wX3F1ZXVlKG5ldCk7DQo+ICsJCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+bG9jaywgZmxhZ3MpOw0KPiArCQlldGhlcl93YWtl
dXBfaG9zdChkZXYtPnBvcnRfdXNiKTsNCj4gKwkJcmV0dXJuIE5FVERFVl9UWF9CVVNZOw0KPiAr
CX0NCj4gKw0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+bG9jaywgZmxhZ3MpOw0K
PiAgDQo+ICAJaWYgKCFpbikgew0KPiBAQCAtMTAxNCw2ICsxMDM3LDQ1IEBAIGludCBnZXRoZXJf
c2V0X2lmbmFtZShzdHJ1Y3QgbmV0X2RldmljZSAqbmV0LCBjb25zdCBjaGFyICpuYW1lLCBpbnQg
bGVuKQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoZ2V0aGVyX3NldF9pZm5hbWUpOw0KPiAg
DQo+ICt2b2lkIGdldGhlcl9zdXNwZW5kKHN0cnVjdCBnZXRoZXIgKmxpbmspDQo+ICt7DQo+ICsJ
c3RydWN0IGV0aF9kZXYgKmRldiA9IGxpbmstPmlvcG9ydDsNCj4gKwl1bnNpZ25lZCBsb25nIGZs
YWdzOw0KPiArDQo+ICsJaWYgKCFkZXYpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWlmIChhdG9t
aWNfcmVhZCgmZGV2LT50eF9xbGVuKSkgew0KPiArCQkvKg0KPiArCQkgKiBUaGVyZSBpcyBhIHRy
YW5zZmVyIGluIHByb2dyZXNzLiBTbyB3ZSB0cmlnZ2VyIGEgcmVtb3RlDQo+ICsJCSAqIHdha2V1
cCB0byBpbmZvcm0gdGhlIGhvc3QuDQo+ICsJCSAqLw0KPiArCQlldGhlcl93YWtldXBfaG9zdChk
ZXYtPnBvcnRfdXNiKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKwlzcGluX2xvY2tfaXJxc2F2
ZSgmZGV2LT5sb2NrLCBmbGFncyk7DQo+ICsJbGluay0+aXNfc3VzcGVuZCA9IHRydWU7DQo+ICsJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7DQo+ICt9DQo+ICtFWFBP
UlRfU1lNQk9MX0dQTChnZXRoZXJfc3VzcGVuZCk7DQo+ICsNCj4gK3ZvaWQgZ2V0aGVyX3Jlc3Vt
ZShzdHJ1Y3QgZ2V0aGVyICpsaW5rKQ0KPiArew0KPiArCXN0cnVjdCBldGhfZGV2ICpkZXYgPSBs
aW5rLT5pb3BvcnQ7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKw0KPiArCWlmICghZGV2
KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlpZiAobmV0aWZfcXVldWVfc3RvcHBlZChkZXYtPm5l
dCkpDQo+ICsJCW5ldGlmX3N0YXJ0X3F1ZXVlKGRldi0+bmV0KTsNCj4gKw0KPiArCXNwaW5fbG9j
a19pcnFzYXZlKCZkZXYtPmxvY2ssIGZsYWdzKTsNCj4gKwlsaW5rLT5pc19zdXNwZW5kID0gZmFs
c2U7DQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7DQo+ICt9
DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChnZXRoZXJfcmVzdW1lKTsNCj4gKw0KPiAgLyoNCj4gICAq
IGdldGhlcl9jbGVhbnVwIC0gcmVtb3ZlIEV0aGVybmV0LW92ZXItVVNCIGRldmljZQ0KPiAgICog
Q29udGV4dDogbWF5IHNsZWVwDQo+IEBAIC0xMTc2LDYgKzEyMzgsNyBAQCB2b2lkIGdldGhlcl9k
aXNjb25uZWN0KHN0cnVjdCBnZXRoZXIgKmxpbmspDQo+ICANCj4gIAlzcGluX2xvY2soJmRldi0+
bG9jayk7DQo+ICAJZGV2LT5wb3J0X3VzYiA9IE5VTEw7DQo+ICsJbGluay0+aXNfc3VzcGVuZCA9
IGZhbHNlOw0KPiAgCXNwaW5fdW5sb2NrKCZkZXYtPmxvY2spOw0KPiAgfQ0KPiAgRVhQT1JUX1NZ
TUJPTF9HUEwoZ2V0aGVyX2Rpc2Nvbm5lY3QpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuaCBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X2V0aGVyLmgNCj4gaW5kZXggNDAxNDQ1NC4uODUxZWUxMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9nYWRn
ZXQvZnVuY3Rpb24vdV9ldGhlci5oDQo+IEBAIC03OSw2ICs3OSw3IEBAIHN0cnVjdCBnZXRoZXIg
ew0KPiAgCS8qIGNhbGxlZCBvbiBuZXR3b3JrIG9wZW4vY2xvc2UgKi8NCj4gIAl2b2lkCQkJCSgq
b3Blbikoc3RydWN0IGdldGhlciAqKTsNCj4gIAl2b2lkCQkJCSgqY2xvc2UpKHN0cnVjdCBnZXRo
ZXIgKik7DQo+ICsJYm9vbAkJCQlpc19zdXNwZW5kOw0KPiAgfTsNCj4gIA0KPiAgI2RlZmluZQlE
RUZBVUxUX0ZJTFRFUgkoVVNCX0NEQ19QQUNLRVRfVFlQRV9CUk9BRENBU1QgXA0KPiBAQCAtMjU4
LDYgKzI1OSw5IEBAIGludCBnZXRoZXJfc2V0X2lmbmFtZShzdHJ1Y3QgbmV0X2RldmljZSAqbmV0
LCBjb25zdCBjaGFyICpuYW1lLCBpbnQgbGVuKTsNCj4gIA0KPiAgdm9pZCBnZXRoZXJfY2xlYW51
cChzdHJ1Y3QgZXRoX2RldiAqZGV2KTsNCj4gIA0KPiArdm9pZCBnZXRoZXJfc3VzcGVuZChzdHJ1
Y3QgZ2V0aGVyICpsaW5rKTsNCj4gK3ZvaWQgZ2V0aGVyX3Jlc3VtZShzdHJ1Y3QgZ2V0aGVyICps
aW5rKTsNCj4gKw0KPiAgLyogY29ubmVjdC9kaXNjb25uZWN0IGlzIGhhbmRsZWQgYnkgaW5kaXZp
ZHVhbCBmdW5jdGlvbnMgKi8NCj4gIHN0cnVjdCBuZXRfZGV2aWNlICpnZXRoZXJfY29ubmVjdChz
dHJ1Y3QgZ2V0aGVyICopOw0KPiAgdm9pZCBnZXRoZXJfZGlzY29ubmVjdChzdHJ1Y3QgZ2V0aGVy
ICopOw0KPiAtLSANCj4gMi43LjQNCj4g
