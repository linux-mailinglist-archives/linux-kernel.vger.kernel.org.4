Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76576C0C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCTIUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCTITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:19:55 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2045.outbound.protection.outlook.com [40.107.12.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C221BC7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hioak4KBJFOAGz/h3t7BUsK+gQ5kgfJLCXDY19cmrr7PSMPhdgSG9KOML26lPk0wpBK/33u3ZRdHzMlyehN90Ds05WnYsf4seVWtNyn9/SH7GNogaGnlF8WAhdpTSUiuBCE7/VxjmLtD+ugbb9MkyjTCXIcLXh2JM8UMV3LwcuDLjVAvAm+cpvbR5rHp4cUc5YKnpXaPwYhHQi4jmDEZ9MHAEXBVEhf5fzJo3ht8YTvOBDnTJ9O+tI3cUJt3JUkjUVBQokpjFrttH637zwDadSFirR6L1VeGdQs5viLTNNGtv4DIrYYYzKhWRPpolvScaxGcWp+BEJJpq/+MVSoTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHyzw+N7qxE/7beEO5UbhtR1nqzsgFMfdoCcQX87IkU=;
 b=oDx1nrUD8/UU/F4ukNmLssJV/NPxq4U5gwlbIckNEAf1uvXiOgFxX3amVT+0h+I0SYcpvoxbQ+emxsnWGaLhrwThBqthbFC+hRQUmHD02Q80IB/Dmif9iHeMywJx+n4NBkTSni4pR5VtBo80t1UhlFbF/RS1gnXte2Ofngq+VNOLVcp59xQdCn5J0pogWPW04x0RgtOZJdQNbvDv3WOTCRuRrDnnMLNqoSE8+OA2hxbjLLFd7DM8dkOE/PcAFn6Gibuluoo6sZaMR4hiGMNzmN1k/0vRd5kBkkLeCLk7DnjdUzrZrEb4EDPOKzp3ZGhkhL858QsMiEguLxyHC+diuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHyzw+N7qxE/7beEO5UbhtR1nqzsgFMfdoCcQX87IkU=;
 b=49T1A6eXTwHXy2idTt+VsdpG1uwGUB6W4dPWRRlFXmzZvvKZJpblSfwepSCiJeUJTEoE8NWkUD/T0/fHJ9GGrgAYdPUuXMKkXPugJR6RvRVj7zKXaG+sZpISwWc7ZiFy2R9c/H67UTrf81ORFtbiqcJLP5ah0k4HxHZwQOIz9RCIiKjzmvgEWx5gpSp2YtnRvodQ9S/B+DhbYMoiNN+o0YQzDNXXWo0q9pBB6x1CBnYzDPALIoqrW4ZjWl1DXaq0QyOP5+6OOFYGGkwB0tyPZiPk+TwKmvTaoQ95ESxNthwvS3NKRBHqelDA2gyYifSWPR/NukAItIjblJSC5nC/4Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3453.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 08:19:45 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 08:19:45 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: arch/powerpc/platforms/83xx/suspend.c:210:3: error: call to
 undeclared function 'enable_kernel_fp'; ISO C99 and later do not support
 implicit function declarations
Thread-Topic: arch/powerpc/platforms/83xx/suspend.c:210:3: error: call to
 undeclared function 'enable_kernel_fp'; ISO C99 and later do not support
 implicit function declarations
Thread-Index: AQHZRDGpPA68aRMS8kSM68YPuPWJx68DgRaA
Date:   Mon, 20 Mar 2023 08:19:45 +0000
Message-ID: <e53780ac-15cd-7aa9-8203-b62a20ae5629@csgroup.eu>
References: <202302181414.nAdxC08J-lkp@intel.com>
 <948cc265-53dd-0a5e-93b6-a0d0fe768198@infradead.org>
In-Reply-To: <948cc265-53dd-0a5e-93b6-a0d0fe768198@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAYP264MB3453:EE_
x-ms-office365-filtering-correlation-id: 53a2847e-c04d-4599-6e34-08db291bdd5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3S3L6kvsPA/Zckav0svO4QvCiNtNhW1sEI+HYkw4ZlIcG5E5Z0X5txZDgpmFsctIkjXSZfyO7ZCAfyoZAt/XuBoZEayJ8ZOVpckLn4b6CbfvH5GiTMtXKOJ29mTyXDUBXAj+xWIDPinLTXPjvsDqa5hY/CGvsJ2sAy4oG7ALWVN04BCPmlk1A/kQAPY4sd9+pAiQyC8OlIWwnnZP4eVce/57esYQALU9P2P/Q8UiCHnBjyNn4TscZVtIBPI1XTLHx375kI//hFP541IHEc5oYwLmnDyTeBsQHEM/QannZA1+Jr4yXnZ0kdwn+k7s8SS/voi/ei5XBEuOC9OWLItfLBX0VCAqgItK1TQB+ojdx+sWUGSaKLektWPJnNPTqtFxpgnqOmgy0ZMZqNZo7pvH2O4U4Klzgp4v02ymXRwuw22ldCeSfsKEHZLAoU73M6+RIdp+7MPed+dFylMiU0If9A49OZv1q2//r0wB2V8c+h1mfh8LZ0P7tOCsQ/c95tD3I9EDZwJ0MN1N0xDsqP0fygKn3+gBdS0EHE8HXbQKBB+7GvKGsk266QI3psN6Zmu76ibp2h0c6OKy0StuAuXIVAPpf55CXXpCMi1DscIOhmHoXSva7DypWwcXrJMafP4ALGA90xUAkhPt67bOOhGT3xNOfgBYDCv+NFuWq2cOj21o8UWxT8ZwhHatnM74U51JtzRUgVpCiZYSFtdNjeAJEhUgG/eNlJgjVz3zl4VvgrAl7JvCMTWDrZzKL2O4QesS5BJPD/sx4Bd9aUTOm8Qqi7Zye+T5VPVltvP7aynRxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39850400004)(346002)(366004)(376002)(451199018)(2616005)(71200400001)(66574015)(186003)(6486002)(966005)(4326008)(478600001)(83380400001)(316002)(110136005)(91956017)(66476007)(66446008)(76116006)(64756008)(66556008)(66946007)(8676002)(31686004)(6512007)(6506007)(26005)(53546011)(54906003)(41300700001)(5660300002)(8936002)(7416002)(44832011)(15650500001)(38100700002)(122000001)(2906002)(86362001)(38070700005)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTlSTEkrUUxZQ3RydXo4aDhhQUtMM25VZ08yWTV6SkZHYTZwVTdnY2RuZlRo?=
 =?utf-8?B?MWM4aVZDWmRDSHBKU2hhUFl3c3l6SjhWZ2ROK1BxS3U0RjBvV1pFaHN4UE5D?=
 =?utf-8?B?OGdLeXFSTGswbGlDdGhhQ25rdFlMSTRRbDgxM0s4VG9ETGpNT1RoaXZhM3Rn?=
 =?utf-8?B?eTE4YmpVWVZubjlsakJVdVc2T0xOT25Dbm14WGZ1YTgxWFZhdkh0NGlpVVJu?=
 =?utf-8?B?MDZGOHZIUE5pbGc1WEVpYlZIQ1dWUjJWM00zZWlNbXpIbENuVThnQ2JlME5L?=
 =?utf-8?B?emdKSnZTNFU5TGJwWStLZStTdldhWi8wTm8rR0VRU3lrVUw2RVNuR2JDUWVF?=
 =?utf-8?B?a05MU2hyNi9IanlmYnlxUEowWTBrYlFleXB3R04yMTJXZ2ZndUJSNTE4WTc5?=
 =?utf-8?B?RDRLaWlrOFFBYTlRRGQyTzhYYXhpN3NwSWdvTkZ5K0lUbDdEek0wTGFsQWkx?=
 =?utf-8?B?eHhaNjdNOGc3S3RwNTVoakF1VnVmLzlhVW5oNk5ueVBFL09SbjBaUndmNDRS?=
 =?utf-8?B?ZVYrUWo4ZWpoc3NreUhUVWY0emh4cTVCTnJHYWRUc1J0TUozWTB3Zy9XQUk5?=
 =?utf-8?B?UjNUYWwvOFowRU0rNmlMOFU0MkRRcGkvQ0Z6R2RjZWpLeVBqRWJaS0VTZEY1?=
 =?utf-8?B?Z3RzajdNZ2ZDUnRkMXJRNXUrY1NpNG9IaU1BbmRoblUwcGpTNE9GRWlvbUhp?=
 =?utf-8?B?YVhLSEczUENnQVZORFFjQU1zYW5BbmhuN0VlSGVxdGNTKzVUcXRvcXVNVERr?=
 =?utf-8?B?K0JJZjFwVUdYcDJlMVFjZGpoT1B6bzZEQnhpSlpmeEZ3MUowdEZJWXRCdGRn?=
 =?utf-8?B?T2JLV1JGSWsyb0JyblpZVUtybEU1ODNZWEU1ejhzSHdpUk15SFhQUmhJQmIy?=
 =?utf-8?B?blpmYnlMOXV0MkhzTDBTcmxSakswNk5tOUR5S05ubWNibW11MUNUVTBtQzFp?=
 =?utf-8?B?WVhoSDZ4anpORndNV2dyNm5aM0VIb3k3cm9IWEVHTXg1ODBGZlBzWmdabWwx?=
 =?utf-8?B?Szd1eGVhc05rSzA5L3dwNms3S2NqMFFJMlBSc0xnZzM4QlY1d25OazN0UFVH?=
 =?utf-8?B?WHdpWmlwRy9wZituSk8zbk0xVGxaTlc4K01JMmJhS2xrL2J4NlduYWFMejVC?=
 =?utf-8?B?TXNLV2pqeEVSSUY1SlhxUWxia1BhYVJXSVJGQ2J3NmpURFBvbHoraUg0OCs5?=
 =?utf-8?B?cHJYMTkzRU8zQ0NIeGxqdVhhQjkwVmhuR0NVd0krQzlPSTlFSC9tTnRLSlFt?=
 =?utf-8?B?MGhiaVlkQTBOdUdQaGl1QkFLUytwdDgvOFYzOU0yZFY2L2lzVlRNaVRtU2x1?=
 =?utf-8?B?ZjdLbjkyTi81bHZ1YlZhS1BGVE1leXV5QXBrUFNENmx5enJhUkNXdzR2N04r?=
 =?utf-8?B?RzNERzg0VUxaNkZyQlo4blFxQm9XT1J2aFFNUVhaa25xcHFLcHkvdmlPMlBQ?=
 =?utf-8?B?L0lmcGJ0V0s1Q1NkVkFVelpKL21jbGpQYVVPYmpQcmhKUTVmdVdNQ0hsbkVD?=
 =?utf-8?B?QlpzcnNyYWFJelF6dXYzK1dJa3JXMzZJeU5BOUhCZXhlWU50a3FVRXVoUUVZ?=
 =?utf-8?B?MTlxSmR5cGk3ZDlXakNIZ3BPV0w2ZGVvcGNXQlQ4YXBJRmNLcm1DYkx5WUVP?=
 =?utf-8?B?Yy9CQU5qb3pyVVZPSXh2UnNWNXBoNVpjWEFkSEZKdk5sUlFwMzY0L1FLdHBj?=
 =?utf-8?B?d3BON0NxdEwrck1HcCtQUUpvQmMrYkpjeXFNVWkwbEYxTkR1TnBqY3RoMWhT?=
 =?utf-8?B?UVdDSEthQzBnRWNuRkU1RXEwbFFTTGNvY1lFUUNjVGE2dGNJTXE0SUFnRmpN?=
 =?utf-8?B?SldpZmhMK240OEtmOHRaaitRM09DVy81MlBVQUgwc2d5bTB5Mkt3Mk9yOHlt?=
 =?utf-8?B?R0pvZ2tUS3h2a0tVcDFTTXorRmtTZVNLeUo2c25JQWxWL1p4aHBoVkVqWXQy?=
 =?utf-8?B?ZmFLL29UVVhqcTEwODdndmpGV1B1YzVtVkhwaEVjOU83TmlaWm9tVC90b0J6?=
 =?utf-8?B?QnRCajVnN1FIdHZoU0F2ZE9xazNyY3VVVnFESTFYRkVSSDQ2SDljc2l6VFJU?=
 =?utf-8?B?ZWZ5Mkg4d0FXLzBjSWdrUDFhZk5UOUN5eVdaTG5YMGxjcThITmN2SGtLY0Rs?=
 =?utf-8?B?ZnZCaVBSODRuUFpmcjV0SW5sanNjd3lkZzJUb0dsSUVleWlBNE5Ic0JxUjAr?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0323687E9689145A298643A9E5CDAEC@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a2847e-c04d-4599-6e34-08db291bdd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 08:19:45.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxxlWjfDLp2qagJLMK2F0UBtKLuvIhE/7w7rSqtZoVFTiMiH9p3adyx4gIC3ho+doWsNTV09lwjkYtD0anPVu+4vTSawBD2IqtRR/AIaieU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNCkxlIDE5LzAyLzIwMjMgw6AgMDg6MTMsIFJhbmR5IER1bmxhcCBhIMOpY3Jp
dMKgOg0KPiBIaSBDaHJpc3RvcGhlLA0KPiANCj4gT24gMi8xNy8yMyAyMjoyMSwga2VybmVsIHRl
c3Qgcm9ib3Qgd3JvdGU6DQo+PiB0cmVlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCBtYXN0ZXINCj4+IGhlYWQ6ICAg
MzhmOGNjZGUwNGEzZmEzMTdiNTFiMDVlNjNjM2NiNTdlMTY0MTkzMQ0KPj4gY29tbWl0OiBlOGMw
NzA4MmE4MTBmYmI5ZGIzMDNhMmI2NmI2NmI4ZDdlNTg4YjUzIEtidWlsZDogbW92ZSB0byAtc3Rk
PWdudTExDQo+PiBkYXRlOiAgIDExIG1vbnRocyBhZ28NCj4+IGNvbmZpZzogcG93ZXJwYy1yYW5k
Y29uZmlnLXIwMTMtMjAyMzAyMTggKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJj
aGl2ZS8yMDIzMDIxOC8yMDIzMDIxODE0MTQubkFkeEMwOEotbGtwQGludGVsLmNvbS9jb25maWcp
DQo+PiBjb21waWxlcjogY2xhbmcgdmVyc2lvbiAxNy4wLjAgKGh0dHBzOi8vZ2l0aHViLmNvbS9s
bHZtL2xsdm0tcHJvamVjdCBkYjg5ODk2YmJiZDIyNTFmZmY0NTc2OTk2MzVhY2JiZWRlZWFkMjdm
KQ0KPj4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKToNCj4+ICAgICAgICAgIHdnZXQg
aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2ludGVsL2xrcC10ZXN0cy9tYXN0ZXIv
c2Jpbi9tYWtlLmNyb3NzIC1PIH4vYmluL21ha2UuY3Jvc3MNCj4+ICAgICAgICAgIGNobW9kICt4
IH4vYmluL21ha2UuY3Jvc3MNCj4+ICAgICAgICAgICMgaW5zdGFsbCBwb3dlcnBjIGNyb3NzIGNv
bXBpbGluZyB0b29sIGZvciBjbGFuZyBidWlsZA0KPj4gICAgICAgICAgIyBhcHQtZ2V0IGluc3Rh
bGwgYmludXRpbHMtcG93ZXJwYy1saW51eC1nbnUNCj4+ICAgICAgICAgICMgaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2Nv
bW1pdC8/aWQ9ZThjMDcwODJhODEwZmJiOWRiMzAzYTJiNjZiNjZiOGQ3ZTU4OGI1Mw0KPj4gICAg
ICAgICAgZ2l0IHJlbW90ZSBhZGQgbGludXMgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0DQo+PiAgICAgICAgICBnaXQgZmV0
Y2ggLS1uby10YWdzIGxpbnVzIG1hc3Rlcg0KPj4gICAgICAgICAgZ2l0IGNoZWNrb3V0IGU4YzA3
MDgyYTgxMGZiYjlkYjMwM2EyYjY2YjY2YjhkN2U1ODhiNTMNCj4+ICAgICAgICAgICMgc2F2ZSB0
aGUgY29uZmlnIGZpbGUNCj4+ICAgICAgICAgIG1rZGlyIGJ1aWxkX2RpciAmJiBjcCBjb25maWcg
YnVpbGRfZGlyLy5jb25maWcNCj4+ICAgICAgICAgIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9N
RS8wZGF5IENPTVBJTEVSPWNsYW5nIG1ha2UuY3Jvc3MgVz0xIE89YnVpbGRfZGlyIEFSQ0g9cG93
ZXJwYyBvbGRkZWZjb25maWcNCj4+ICAgICAgICAgIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9N
RS8wZGF5IENPTVBJTEVSPWNsYW5nIG1ha2UuY3Jvc3MgVz0xIE89YnVpbGRfZGlyIEFSQ0g9cG93
ZXJwYyBTSEVMTD0vYmluL2Jhc2ggYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84M3h4LyBkcml2ZXJz
L2FuZHJvaWQvDQo+Pg0KPj4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93
aW5nIHRhZyB3aGVyZSBhcHBsaWNhYmxlDQo+PiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCBy
b2JvdCA8bGtwQGludGVsLmNvbT4NCj4+IHwgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
b2Uta2J1aWxkLWFsbC8yMDIzMDIxODE0MTQubkFkeEMwOEotbGtwQGludGVsLmNvbS8NCj4+DQo+
PiBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+Pg0KPj4+PiBhcmNoL3Bv
d2VycGMvcGxhdGZvcm1zLzgzeHgvc3VzcGVuZC5jOjIxMDozOiBlcnJvcjogY2FsbCB0byB1bmRl
Y2xhcmVkIGZ1bmN0aW9uICdlbmFibGVfa2VybmVsX2ZwJzsgSVNPIEM5OSBhbmQgbGF0ZXIgZG8g
bm90IHN1cHBvcnQgaW1wbGljaXQgZnVuY3Rpb24gZGVjbGFyYXRpb25zIFstV2ltcGxpY2l0LWZ1
bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPj4gICAgICAgICAgICAgICAgICAgICBlbmFibGVfa2VybmVs
X2ZwKCk7DQo+PiAgICAgICAgICAgICAgICAgICAgIF4NCj4+ICAgICBhcmNoL3Bvd2VycGMvcGxh
dGZvcm1zLzgzeHgvc3VzcGVuZC5jOjIxMDozOiBub3RlOiBkaWQgeW91IG1lYW4gJ2VuYWJsZV9r
ZXJuZWxfdnN4Jz8NCj4+ICAgICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc3dpdGNoX3RvLmg6
NzU6MjA6IG5vdGU6ICdlbmFibGVfa2VybmVsX3ZzeCcgZGVjbGFyZWQgaGVyZQ0KPj4gICAgIHN0
YXRpYyBpbmxpbmUgdm9pZCBlbmFibGVfa2VybmVsX3ZzeCh2b2lkKQ0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICBeDQo+PiAgICAgMSBlcnJvciBnZW5lcmF0ZWQuDQo+Pg0KPiANCj4gV2hlbiAj
IENPTkZJR19QUENfRlBVIGlzIG5vdCBzZXQsIGVuYWJsZV9rZXJuZWxfZnAoKSBpcyBub3QgZGVm
aW5lZC4NCj4gTG9va3MgdG8gbWUgbGlrZSBpdCBpcyBjYXVzZWQgYnk6DQo+IA0KPiBjb21taXQg
N2Q2OGM4OTE2OTUwDQo+IEF1dGhvcjogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJv
eUBjc2dyb3VwLmV1Pg0KPiBEYXRlOiAgIFR1ZSBBdWcgMTggMTc6MTk6MTggMjAyMCArMDAwMA0K
PiANCj4gICAgICBwb3dlcnBjLzMyczogQWxsb3cgZGVzZWxlY3RpbmcgQ09ORklHX1BQQ19GUFUg
b24gbXBjODMyeA0KPiANCj4gQWRkaW5nIGEgc3R1YiBmb3IgZW5hYmxlX2tlcm5lbF9mcCgpIGlu
IGluY2x1ZGUvYXNtL3N3aXRjaF90by5oDQo+IG1ha2VzIHRoaXMgcHJvYmxlbSBkaXNhcHBlYXIu
IChUaGVyZSBpcyBzdGlsbCBhIGRpZmZlcmVudCBidWlsZCBlcnJvci4pDQo+IA0KPiBJZGVhcz8N
Cj4gDQoNCkkgdGhpbmsgaXQgc2hvdWxkIGJlIGhhbmRsZWQgbGlrZSBBTFRJVkVDLg0KDQpJIHdp
bGwgaGF2ZSBhIGxvb2sgYXQgaXQuDQoNCkNocmlzdG9waGUNCg==
