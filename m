Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8691874FA34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGKV7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGKV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:59:16 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C4F170A;
        Tue, 11 Jul 2023 14:59:15 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BK0uZP022062;
        Tue, 11 Jul 2023 14:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ubkVr2rP0YvHN3MPGJPfzU6hdS46u8piXcDkHrPbyaU=;
 b=KWqA/Jry9k1zFmzlJTr34jrFoOa2/VmdkSjeeHwswcnlBOfoox6iURZv/yYb4QEikTja
 JGzksbuL/8tKpfaN8WF0C4wGwMjY+0AhlNQ+W1K85OCxuKedWgtTd4/4DIpjEeSQZxeS
 JPtQkvYIio+qUQ6afcKcEV5ueqpigl2ytpwPMKx0pC4hkeBlstA0MBmEoSpGh24hlXhD
 k5fOoxOsM3QLHMfT/qUxQpEixA9+Aeu9/UV6o87Z0zMrts/ZINc+42DQ1MZKJXX0o5Wz
 o0FQjuHq+NcHNp3uLJZ3yQQzlz3fDvEpM+d3Bbr9PEE1IngfvWcfZHnf1Y9pxGhj6TDx Eg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rq6qv6mxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689112740; bh=ubkVr2rP0YvHN3MPGJPfzU6hdS46u8piXcDkHrPbyaU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ipZyJfqNp7JJnE629V4mKKsT4T9RHMLvZqlsTdh4RR/Ht4g6P3wj4D53XwlUEeIXY
         0QEms6/TaXTuzUeTWkmA/xOj2b4rphc7WxB4h+k+XBrloVY0NeeGdPu3qdKoysmKUJ
         bpVaZMwvjJGjkn+4FiFqsU+M30BdMEMklfZTcpPpmcIzIvgUwBscM1kDtbGOUF5GB1
         UjXyIRrR/z+h+khlPboklqdOsAl+IqI6MmeXXScBHiy9LGdHo/LEDjY4LJL2Kd5LCa
         WHxmqpZl6HMr51lMERPSq+oLoMlgDpy4v499V8hCfPm8CH+r1ldULLdWYcc64Y40kp
         wu6sHzukVIdEg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 194DB401D0;
        Tue, 11 Jul 2023 21:59:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E07A1A024A;
        Tue, 11 Jul 2023 21:58:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=iqUp1eUv;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AEDF940087;
        Tue, 11 Jul 2023 21:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxM8wjqha8fL0i6IWoSM01b8gw/pmAXsO2XXjTl6iJC6/BvfbkXNZg8/ywkj4rne33BOE5k4ZXR9kZeog+GFCSvFLMGyTZoHpqax4K39FK9M/wLME9RJ3eR984e5GqGJDqtStsIC3BbJcP3Ic6GBab4bJHM7KihFltqrG70gH1R0KpYKMwWe66QktSx/LV11wzqWJSDSf8/n5n3ZMRGnXeWnASLKuImt+kCtmllDJ7nXSaNhxhyQdJ7J/pj/1yxGexX+N4TKIISNHJhL+zZU4mfkiPF8ifDyI2PAXEigs8bJjXPDQ8B7kXHT145qdns6Tdo49IA8q8XTliSXV9MCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubkVr2rP0YvHN3MPGJPfzU6hdS46u8piXcDkHrPbyaU=;
 b=b1wL+pa6xa9KGhZWS2BQASoFJqqtbZ/TSLI+Dqg6IB+xyJdgZiqVs7pBWXgwwLESOFMVwh8/u0LQZLDvcypD0aFWDm27OPjP3ofbjkn6T8HrpDSeGNRV5VpIKTCsBii+fd4WRG8iLUUeDSXbBAqWFt/y6uHp7ANDbMEI4yEGdAxsdjZYiiNkGRXUfwkRXJngqZe3VjH5tsLixkVATAdosa7Sgs1G5yinqJi7FMva/23Dc9eC20uPudJi1Z6kuryjodSDHaIle0Z+NB6uoLxws4v3b14+gh663icN6H0+2HszUiK9p34aYX41fXtdzbXSLuzAN8ifrc7yCYEaXoiGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubkVr2rP0YvHN3MPGJPfzU6hdS46u8piXcDkHrPbyaU=;
 b=iqUp1eUvq7/dryaW4IdUCC0gdca34nrllwG7DwVI3eF7lFXwpUtXsYj62NVcrGTTRh/XYljWfOclLRGan6mSewAJL+/yXIbLApAtQpUhvy0FDWQUAFT7Tzqx1GQlu9BBBHSa2YUiyd8j0KbmgbTQy5IrJSJrLa/+9kX4sHWnFMU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 21:58:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 21:58:55 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v3 0/3] Support dwc3 runtime suspend during bus suspend
Thread-Topic: [PATCH v3 0/3] Support dwc3 runtime suspend during bus suspend
Thread-Index: AQHZtB9Ad+n5ma7+Bke/o9ZPd7A91q+1HYSA
Date:   Tue, 11 Jul 2023 21:58:55 +0000
Message-ID: <20230711215853.qe5gc2terlsgdapg@synopsys.com>
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
In-Reply-To: <20230711174320.24058-1-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7562:EE_
x-ms-office365-filtering-correlation-id: 1c57ead3-139c-4e6c-7371-08db825a05d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4wvfyZ/vKsGehwJMr5hiQEYac5DReJsK/LJMZk2T7HTkkT/SouR0QXgORnz4/ZwOEi+NkGJd7Mvy3/HudFLnpKosScvcJo0V/6ywwxZyViYy+sdGNkTbU2mSLgFjziV0RP9KeGCr84fFind07XtI0et4FW7F/zoyeuC5oazvV1Qm4VvF7eXIwdTx0rgoeUbL0iM8lbuci/R0FqNmmmp3ANGoA1WrFfMipc2MILhsvsz7OyYJu3ndQB8RITvyC38pVoq2rtQE7oC/9DvrnL8rIj9SxN9Buw6msVVF+uTC8fJ+FqOpID44zpbSAzsd/mrpHQGdOONNTdcLeVBXegIK6nuMkvLL3oCWot8ga8SzEd3H00NrPi4m7bItbbUQBJFpO4gkVj9numdCYE+jfGKQF9ZK5n0RAecPq3NEBR91CkQ+Q0dewdk14tJW3QKc4D1dwWTlNmIGIK1Wg8a1eR079iSsAgvhf9OoKJs3PCkV44tygLnI7vDPhoGMThhpXPKZ6ulbyuQ/vXY1KruCeHwRdZppFPGtmN6d4YMFCSaxgTAIE1ldBua1cPDzDpp13GdgMULx4blHO7pb8EBX/jjwzK4ZzCQtcq3bd3r4pe7gRXohhP56agUwBnMSLxMJfE3K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(6486002)(6916009)(4326008)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(478600001)(26005)(1076003)(6506007)(122000001)(38100700002)(54906003)(71200400001)(316002)(41300700001)(6512007)(38070700005)(8676002)(8936002)(86362001)(5660300002)(15650500001)(186003)(83380400001)(2616005)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUl4d0d2dklMNE1vd0dSenhaRkpVVDZiTXpuT2Q5ZGx3ZnpNN1Y5V3Uxc3RR?=
 =?utf-8?B?NjZvdXBOSVpqeFZkakxmRER0UFBmUkh0WjN2blZOZ25GM0RPdE5tTGJXd0xu?=
 =?utf-8?B?czY2RmlSSTdPbjF5dFV2cnZSQmlKQlY0UFpOZUhwZVV3Nnl4NnMwZTJtV1Iy?=
 =?utf-8?B?aG1nYnk3WGlsWHllcXVLYW51RjUwTk9zSnBWR21qWHU0ODkvRHFjS280WkNJ?=
 =?utf-8?B?MEFNaVovMDExSzJQd0tydGFRUEp0SGxQbVpCSkFsOUg5emw4R3hjS25DVHZj?=
 =?utf-8?B?UTlKSTRjeFk4WllVUFppWXYvKzk4OGRqcWZxQ3lZb3A0V2lEbHcwVjNUUy91?=
 =?utf-8?B?Uk12b3NicEpYZXhhT052ajlQTWM1UXZ5LzJoaExKV0tmMTFXdUVYMjQ1OU9L?=
 =?utf-8?B?NkRPOXVQVkJHaHpqdzBsL2dhVEs3bHZSTHcxSzVMTVlORUJ4N2FacEdDdFBy?=
 =?utf-8?B?OTNYVnpST0ZGQlRTcUlvWERRdjNReERUVzgvekx4dXZsQ1lCSHZ6MUZTVWFi?=
 =?utf-8?B?U3pTVjJrOHlqbGNYUTRkK2VHQW9qaHNJdEVNMEVLSkdpdFpHTmo4cWtYZ2lj?=
 =?utf-8?B?b05meGtBVCtGc3dlQjUrOXpZSWRjRDlya3JrODY0VWRtQ1pyeDFiMjgwa0p0?=
 =?utf-8?B?M1VRN2F2OFEwWiticjJiRFBvWmhydFNaRWp4bnFGL1l1NkZscmJIMlNmWUpa?=
 =?utf-8?B?M0l1akZzSFp0VGVESFBUdHdLY0lsa2c5dmpNcEJoWWFncmRtdFZJNlUrRkhK?=
 =?utf-8?B?TFhXNWt4aWdiZVhpVTd2WFlkRUM5SkRxb3ZyUXhNMUxrcjdGalJVVmZZS2lN?=
 =?utf-8?B?bldoRjdqSHdtWWRFZW1wWFZab2JrdDVFK1NVVUJQaUpSN3Z6Zm5qS0JEcjd4?=
 =?utf-8?B?K1prTUlrZ2d3VEhiR2dMSDRhOFl3SDVuMW5jQXA3bWRiZloxM2FvZVdaaHVn?=
 =?utf-8?B?SDlrcElrbkczSkpFaGZzdlR4ZFZQT2k0M1R1QUR0eUxYVVltWUVQUENIZ1V0?=
 =?utf-8?B?WU1aUjhCcGYxZU9FNm9XK0VwSlRuWE1CZ2dPZkZpbk9ER3QrT1dEbGJjK0M5?=
 =?utf-8?B?NGpMRU5zSmhEdnMyWG1Bb1Zua1VhZjgxZFlqbTl2OUk2RHUrRDY1M1VTRGI1?=
 =?utf-8?B?Z1hndVhiNFRmaUpVYkNtVHg4LzBXaWV6VWg1SURNdlBWdnkzb1VqMkM3cW9K?=
 =?utf-8?B?VzNUNUhnTnUxVnUrdytFRFZ5aWI0WEFmejZBQjdVQWR6cjFDS21oanRCVHM5?=
 =?utf-8?B?WWN2SnJBajVYdXlCM0xubFBCaFNFSURaQUs1azR0SFY0V0M0L3VNM1B2Nit0?=
 =?utf-8?B?dGdhQjRWNnk0d05QaVNIMEx5cGlwNDFxZS9NZGtyY1FEc1laU1oxa1pVYm9i?=
 =?utf-8?B?NUxKTkhZd0RyaEQyTmFBLzJxS1NCNE9rTncxUGFCbTlzd20zdXE5UXVMMndN?=
 =?utf-8?B?ME5rYTMwV0JrMGdRWTBPSnZhUTlPald2R3BTMEhTM3o1czY2Z0ZzU3JwdFNU?=
 =?utf-8?B?cDZ3VzJmazUvcGNzV09LTkp1TTFjby9BMU9PYzdtODFNd0ljYWoxdmZ0SWV3?=
 =?utf-8?B?Um5GK0pvcWR4cU1zcXdyTklTMDcyT1kvTFZtRkdUaEt5Sm9kd21yZzNNWEZY?=
 =?utf-8?B?UWIvUDZPdlNFdG9YT0xxK014dTdTMEhZYjFCaGw4Yk1VcTlCZWROaXViQjY5?=
 =?utf-8?B?bHFlamxtVnErUFB6dHhpSlpMZVJiMlJ5VWJsZ1hwYWRrTEt5UXJwbm9kTUs1?=
 =?utf-8?B?TUd4aURqVEttRWg5THltWkszZHZwc2JRdUg2b09PZ0VGbG44QVd4OVRCT0Rs?=
 =?utf-8?B?cm9INzBBOE9ldXFtWjdTZkxOM2h1VEtodGJaNTlBRlNwOGNWTWYwRVhtanky?=
 =?utf-8?B?SWpOL2N2QytWY0h3S29xQnFmdlhqbDdCeERETFBrbVIyZFd6ZklRSUIrdUQ3?=
 =?utf-8?B?Z3phNnlOWGpLZWVkcTl0V2tTMzRvZG0renhOVGNRQldiVEdWYzJwUDN2L1ZE?=
 =?utf-8?B?azR1R29ZcjIzM0hMZ2F1bjM3Q0Q1VG5zRVF0NWR1U2REbGQ0RVdVOEhQNlBa?=
 =?utf-8?B?QjZVMEUvVm0yRFZXTXR0azVWQ21aV0RyUmY5UU11SUpmSmlJY2ZmOS9qZDdh?=
 =?utf-8?B?STF1RWFTWXh1WUVjU2twY01YbWNGYkQ1QW50T0RNOGhuQWlLOWZvY0t4dER3?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <101A5FE39F007D4E8B9AC898A77FFD60@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TEZhZUkxYlo2MDh6NjNINlYzQ1hSSzdtYi9idlJGRmMwSUxUWWphU2xkQWxX?=
 =?utf-8?B?dVJkcXdPR2ZkMU1NN1BUNXVtbFBTMjdzL3J4My9PWWJGdzlUSlRFWE5YQTBn?=
 =?utf-8?B?WVJWZnJXaHZYZVl2U0IzZXI2WE5JUzFDWldSWUFGUlhJakpOUmJETnRNejBp?=
 =?utf-8?B?aDVaT1g2UExZWkJQbFpBVTBYcnRpeTJDbVpXR2tUcU5KNEtYWVB2ODU2M1Qr?=
 =?utf-8?B?c0tMS2g3MFhiTHdpV2dzZHJSdC9vSE9lK1U2Y1E2OTZMZ1FNK0JieXFWZm1v?=
 =?utf-8?B?dDl1NW9rMFNid1BndEd6U2syWHJIUW5zbGoxcGx5MlNGeHBibHBvclhobVVE?=
 =?utf-8?B?UElKdkJvZGg0QXVTSTZ6aUhyUHdWRHVES3lXRnJLQndGc0J3OTJ2c29Hd1NY?=
 =?utf-8?B?bzVMNU96Smg2NlN2VXZ3N28rRUxPR2U0VlhhZktSQkNnbTFSdytHQUlYRCtq?=
 =?utf-8?B?d28rZ2ltTHF3a0s0aVFwVWhYeTdOV3ZkcHk0dVM3cGNIVCtFRjd6V3dMemRq?=
 =?utf-8?B?elpWb2VwWmpXcXg5QStTcDAyT0lKWjczRjk0ZEJBMFB4MHA4dHRRWURWbHN4?=
 =?utf-8?B?blI2OU1mc3Q4SUVuTjJaZk4wNzFHODkraHpuYjVEc0VmOXB6YTkwT0JjTk1D?=
 =?utf-8?B?KzFQQlVZQ2JTSzhsd09lUnNQWFBEZlQxQmVpck85OFdkWWMrWW54MWFDcG5p?=
 =?utf-8?B?WDVvTmFyeHd0SzFncldNR25UdDNObitVNVNGSEYzZWduWWVUUnNZaTMvREc1?=
 =?utf-8?B?QVRyeElwa3N3aFZHT0xpczVzMFdMZHRvNzhWU21QT0dKK01sRnQ5KytNVVpT?=
 =?utf-8?B?bW1hMTJtN2hOcW0zeDUvVlpTSUpKRlU3OVIvQ2VJYTVvR2VTUmoxSWJpU0Yx?=
 =?utf-8?B?dFJIaElTMEFtcVhCWWRsaGxrbXVqM3B6b21DZ1BtdmRHaXRsbCtqRkkwRDB4?=
 =?utf-8?B?TXd4WEErQWpORkpseW5RZDVTalZ2TmJueXZhRXhxN3lkdkp2dm9mN2Q3dmlj?=
 =?utf-8?B?WGFSejk1SUQ2TEEzZFdGa05jNjVVSGxyOGYwZXJXLzh3WU9TL1BEdDR6bHl3?=
 =?utf-8?B?a0VhMVdJNS8xaFM0cmw2RVJhanFPYlNPUlFqeVlDQ0lGQm9Vb1BwaVluN3hp?=
 =?utf-8?B?UHZMUjNnQ0NKRUk1RjZNRVE1UWxHMmY0RS9rblYzd3BMNS8vc2xOUTJiaytP?=
 =?utf-8?B?U0lyNlNrNXNXS3hXSDZUTmVDMFpVeEsxOXhQM3F2VFp2Qld4WGhQZmRLbEZW?=
 =?utf-8?B?TmRVWUwrSWVzTUhSTWxXNTZBTUE3YndxU0FCdTJodXN0SjRuZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c57ead3-139c-4e6c-7371-08db825a05d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 21:58:55.9124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbEE8A/G6cNkjDVuf8txuSG1fh6lKlkjKE2tL9oBmy1TwaKETR2G//yD7ZizLBHpa4jSzDddwPvs0BKtsscsUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
X-Proofpoint-GUID: 91G_IEW0dJcGornjBZTQcRgTypiF-7w0
X-Proofpoint-ORIG-GUID: 91G_IEW0dJcGornjBZTQcRgTypiF-7w0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=626
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307110199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgMTEsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IENoYW5nZXMg
aW4gdjMNCj4gIC0gQWRkZWQgYSBkdCBwcm9wZXJ0eSAnc25wcyxhbGxvdy1ydHN1c3Atb24tdTMn
IHRvIG1ha2UgdGhpcyBmZWF0dXJlIHBsYXRmb3JtDQo+ICAgIGRlcGVuZGVudCBhcyBwZXIgdGhl
IGZlZWRiYWNrIGZyb20gVGhpbmggTi4NCj4gIC0gQ2hhbmdlZCB0aGUgUlQgaWRsZS9zdXNwZW5k
L3Jlc3VtZSBoYW5kbGluZyB0byBkZXZpY2UgbW9kZSBzcGVjaWZpYyBhbmQgZHQNCj4gICAgcHJv
cGVydHkgZGVwZW5kZW50Lg0KPiAgLSBNb2RpZmllZCB0aGUgY292ZXIgbGV0dGVyIHRvIGRvY3Vt
ZW50IGhvdyByZXN1bWUgaXMgaGFuZGxlZCBvbiBxY29tIHBsYXRmb3Jtcy4NCj4gIA0KPiBDaGFu
Z2VzIGluIHYyDQo+ICAtIFVzZWQgcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpIEFQSSBpbnN0
ZWFkIG9mIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKQ0KPiAgICBhcyBzdWdnZXN0ZWQgYnkgRGFuLg0K
PiAgLSBIYW5kbGVkIHRoZSByZXR1cm4gdmFsdWUgaW4gZXRoZXJfd2FrZXVwX2hvc3QgdG8gcHJp
bnQgZXJyb3IgbWVzc2FnZS4NCj4gDQo+IFdoZW4gYSBVU0IgbGluayBpcyBpZGxlLCB0aGUgaG9z
dCBzZW5kcyBhIGJ1cyBzdXNwZW5kIGV2ZW50IHRvIHRoZSBkZXZpY2UNCj4gc28gdGhhdCB0aGUg
ZGV2aWNlIGNhbiBzYXZlIHBvd2VyLiBCdXQgdHJ1ZSBwb3dlciBzYXZpbmdzIGR1cmluZyBidXMN
Cj4gc3VzcGVuZCBjYW4gYmUgc2VlbiBvbmx5IGlmIHdlIGxldCB0aGUgVVNCIGNvbnRyb2xsZXIg
ZW50ZXIgbG93IHBvd2VyDQo+IG1vZGUgYW5kIHR1cm4gb2ZmIHRoZSBjbG9ja3MuIFZlbmRvciBk
cml2ZXJzIG1heSBoYXZlIHRoZWlyIG93biBydW50aW1lDQo+IHBvd2VyIG1hbmFnZW1lbnQgZnJh
bWV3b3JrIHRvIHBvd2VyIHVwL2Rvd24gdGhlIGNvbnRyb2xsZXIuIEJ1dCBzaW5jZQ0KPiB2ZW5k
b3IgZHJpdmVycycgcnVudGltZSBzdXNwZW5kL3Jlc3VtZSByb3V0aW5lcyBkZXBlbmQgb24gdGhl
IGR3YzMgY2hpbGQNCj4gbm9kZSB3ZSB3b3VsZCBuZWVkIGEgZnJhbWV3b3JrIHRvIHRyaWdnZXIg
ZHdjMyBydW50aW1lIHBtIG9wcyB3aGVuZXZlciBhDQo+IGJ1cyBzdXNwZW5kIGlzIHJlY2VpdmVk
LiBJZiB0aGUgZGV2aWNlIHdhbnRzIHRvIGV4aXQgZnJvbSBidXMgc3VzcGVuZA0KPiBzdGF0ZSBp
dCBjYW4gc2VuZCBhIHdha2V1cCBzaWduYWwgdG8gdGhlIGhvc3QgYnkgZmlyc3QgYnJpbmdpbmcg
b3V0IHRoZQ0KPiBjb250cm9sbGVyIGZyb20gbG93IHBvd2VyIG1vZGUuIFRoaXMgc2VyaWVzIGlt
cGxlbWVudHMgdGhlIG5lZWRlZA0KPiBmcmFtZXdvcmsgdG8gYWNoaWV2ZSB0aGlzIGZ1bmN0aW9u
YWxpdHkgd2hlbiBhIGJ1cyBzdXNwZW5kIGludGVydXB0IGlzDQo+IHJlY2VpdmVkLiBUaGUgYXNz
dW1wdGlvbiBoZXJlIGlzIHRoYXQgdGhlIGR3YzMgaGliZXJuYXRpb24gZmVhdHVyZSBpcyBub3QN
Cj4gZW5hYmxlZCBhbmQgdGhlIHBsYXRmb3JtIGlzIHJlc3BvbnNpYmxlIGluIGRldGVjdGluZyB0
aGUgcmVzdW1lIGV2ZW50cyB0bw0KPiBicmluZyB0aGUgY29udHJvbGxlciBvdXQgb2Ygc3VzcGVu
ZC4NCj4gDQo+IE9uIFF1YWxjb21tIHBsYXRmb3JtcyB0aGUgYnVzIHJlc3VtZSBpcyBoYW5kbGVk
IHRocm91Z2ggUGh5IGFuZCBpbmZvcm1lZCB0bw0KPiBzb2Z0d2FyZSB0aHJvdWdoIHdha2V1cCBj
YXBhYmxlIHBoeSBpbnRlcnJ1cHRzLg0KPiB1c2IyIFBIWSBpcyBjb25maWd1cmVkIHRvIGRldGVj
dCB0aGUgUmVzdW1lIEsgZXZlbnQgYW5kIHNlbmRzIGFuIGludGVycnVwdA0KPiB3aGVuIHRoaXMg
ZXZlbnQgaXMgZGV0ZWN0ZWQuIFRoaXMgd291bGQgdHJpZ2dlciB0aGUgcnVudGltZSByZXN1bWUg
b2YgdGhlDQo+IGdsdWUgZHJpdmVyIHdoaWNoIHdvdWxkIGludHJpbnNpY2FsbHkgd2FrZXVwIHRo
ZSBkd2MzIGNoaWxkLiBJbiBjYXNlIG9mIHVzYjMgUEhZLA0KPiBpdCBpcyBjb25maWd1cmVkIHRv
IGRldGVjdCB0aGUgTEZQUyB3YWtlIHNpZ25hbCBkdXJpbmcgYnVzIHJlc3VtZSBhbmQgdGhlDQo+
IGNvcnJlc3BvbmRpbmcgaW50ZXJydXB0IHRyaWdnZXJzIHRoZSBydW50aW1lIHJlc3VtZSBvZiB0
aGUgZ2x1ZSBkcml2ZXIuDQoNClRoYW5rcyBmb3IgdGhlIGluZm8gY29uZmlybWluZyB0aGF0IGl0
J3MgY2FwYWJsZSBmb3IgYm90aCB1c2IzIGFuZCB1c2IyLg0KDQpCUiwNClRoaW5oDQoNCj4gDQo+
IFRoZSBzZXJpZXMgaXMgb3JnYW5pemVkIGluIGJlbG93IGZhc2hpb246DQo+IFBhdGNoIDE6IFRo
aXMgaW5jbHVkZXMgdGhlIG1vZGlmaWNhdGlvbiBuZWVkZWQgZnJvbSBmdW5jdGlvbiBkcml2ZXJz
IHRvIGxldA0KPiBVREMgZW50ZXIgbG93IHBvd2VyIG1vZGUgd2l0aCB1X2V0aGVyIGFzIGFuIGV4
YW1wbGUuDQo+IFBhdGNoIDI6IE5ldyBkdCBwcm9wZXJ0eSB0byBhbGxvdyBkd2MzIHJ1bnRpbWUg
c3VzcGVkbiBkdXJpbmcgYnVzIHN1c3BlbmQgc2NlbmFyaW8uIA0KPiBQYXRjaCAzOiBUaGlzIGhh
cyB0aGUgbW9kaWZpY2F0aW9uIG5lZWRlZCBpbiB0aGUgVURDIGRyaXZlciB0byB0cmlnZ2VyIHJ1
bnRpbWUNCj4gc3VzcGVuZCB3aGVuZSBhIGJ1cyBzdXNwZW5kIGludGVycnVwdCBpcyByZWNlaXZl
ZC4gU2luY2UgdGhpcyBpcyBhIHBsYXRmb3JtDQo+IGRlcGVuZGVudCBjaGFuZ2UgaXQgaXMgbWFk
ZSBhcHBsaWNhYmxlIHRocm91Z2ggYSBkdCBwcm9wZXJ0eS4gVGhpcyBhbHNvIGhhbmRsZXMNCj4g
cmVzdW1lIGFuZCByZW1vdGUgd2FrZXVwIG1vZGlmaWNhdGlvbnMgZnJvbSBwb3dlciBtYW5hZ2Vt
ZW50IHBlcnNwZWN0aXZlLg0KPiANCj4gRWxzb24gUm95IFNlcnJhbyAoMyk6DQo+ICAgdXNiOiBm
dW5jdGlvbjogdV9ldGhlcjogSGFuZGxlIHJ4IHJlcXVlc3RzIGR1cmluZyBzdXNwZW5kL3Jlc3Vt
ZQ0KPiAgIGR0LWJpbmRpbmdzOiB1c2I6IHNucHMsZHdjMzogQWRkIGFsbG93LXJ0c3VzcC1vbi11
MyBwcm9wZXJ0eQ0KPiAgIHVzYjogZHdjMzogTW9kaWZ5IHJ1bnRpbWUgcG0gb3BzIHRvIGhhbmRs
ZSBidXMgc3VzcGVuZA0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3
YzMueWFtbCAgICB8ICA1ICsrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyAgICAgICAgICAg
ICAgICAgICAgICAgfCAyNiArKysrKysrKy0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMyArKw0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyAgICAgICAgICAgICAgICAgICAgIHwgNDAgKysrKysrKysrKysrKy0tLQ0KPiAgZHJpdmVycy91
c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuYyAgICAgICAgIHwgNDcgKysrKysrKysrKysrKysr
LS0tLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAxMDIgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25z
KC0pDQo+IA0KPiAtLSANCj4gMi4xNy4xDQo+IA==
