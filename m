Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A039715C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjE3K6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjE3K5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:57:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA9FC;
        Tue, 30 May 2023 03:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj8cFzy+v/w+Ti8JmnNXu3jKkqt2Wwj8uMTw2szk74t1nabwrL/C7svtEZUZhJrmWzAOoEdlbEoq8hjHjRmTAq8S8bnlZLWODX3Ny2IRLB6FueyVLP1u6L4U/sch7kwp75lQBio9x3JyORjyYA4ZyX7YTgmqqNDdD4BOyq5gPbMobTkMsKpKJwF1D8DlAJbNFfzjzBjPrphJih5uo8MmmoS+uX9b6D1u8KS5aSlOAdIn3kVRCW6vBLWiet4A/P2Vkqp+7KfTFR5gxYq+N9sOQOKUKCysXideXRTQVeQ8g3gj3LLKN5B1ng2ONgKy+NjMk1bKINZQZUwYuL3jVMd1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fBQv9VUtumB5k9LA0MhpkApHqjK3J/ljQ5wfMdggQ8=;
 b=cVWcKl+LsnhBxiIXTmWI6FfQrSS/kqtG4RNX9fRtST1aJy5VP0FOyx4dRauw8YAoSjQUDenzt1X+ZtDt2Q/KkdzeclM1GZ+u6nGdszwqm96VP5v8xwdlfe7QRQ7jN0lFLtH9wh1un2kBy8iuIOad4GhzDgA1XtorN/634MU2HfZDS0DclC6PcavKJqW5evJgFdDXuZWLrXNTKp69SyePMu93r41XWlY4zzWGliTqDtXNS7SRPpoFva4Ez4RODMjBJ/t0pBatqYTtF3B2W4t+KEKroBqxfUWsoF658kHzisXmH96WwY3hMELUa18sSes/f0YgaIBRblX44JSdcR6ngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fBQv9VUtumB5k9LA0MhpkApHqjK3J/ljQ5wfMdggQ8=;
 b=A/yzwRxAC6+xoFP+WKc8427t6zEww9RGzDd70QhN1X+txaZV/jQJRYJvZM6JxZQ+jUC7+Wp9YTsXwaUvdlEX+UK0g/LwarBNeNx43nC6hPsA4IO3z9lKkGhQKv+i82iY1O/qNO3tMTyEs6nvFLL+bAmJ0P8qDHvIbvrPBean7Ue2pZ+E2qqFfgz8aTUIpGXQM8tjAeUJELkmee/trNHBjuMleide7Iq6DsS1lA4VRO01zabsVjapUC+YAcjMPUhK6qn71gEEHeCm7Zhl/t6vTQEe8Bcq/GF/fYvqBFUwe9RJmZZ9q/nIWcASQlzmq3DlQgzFoVIHaZ3HEBVCI1hHQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB6180.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 10:57:35 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 10:57:35 +0000
Date:   Tue, 30 May 2023 12:57:27 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     simon.guinot@sequanux.org
Cc:     Linus Walleij <linus.walleij@linaro.org>, xingtong_wu@163.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with
 other gpio pins
Message-ID: <20230530125727.688b6042@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZHSunJyh2AU1eb0H@localhost>
References: <20230529025011.2806-1-xingtong_wu@163.com>
        <20230529025011.2806-2-xingtong_wu@163.com>
        <ZHSZ9cK78qc5QeZD@localhost>
        <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
        <ZHSunJyh2AU1eb0H@localhost>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdccd41-450b-40fa-6fd9-08db60fcac92
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46c6hnI/1bwE+I/KoQFaGlZaFNTQt7EpIYjyD9emjosmDZlzOjlMetaSGG3gt91diIXgJbgxSWdjYodBISQa3ThLWfCFGI8u78C2wor1pOISpHKs0DffRXvuqOe6TI7Bjt3/sZhELwhfRy1BJ2Um3eWUK1yhfoD1n8/MDrFfKd1PZzvfTPV8tZ1jQfXC7KbjTY/98izby3/oztu+IuijjMeToe4fJeqlnX5s9oCZOkHczeDWfVFFmV89ynsW1fJN7WBECIWgCYPgGls/OFj7lPSj3d0d7BaR6Xo+VOuPzDSQyOVox9P/pBAAjrVNGAc6ZMu8REXbBqaKlyyLVfjRzOoKwJ8QbjwyIGyLchtyG94j9X0b+0eY1thlXyBi6NwzMyQlff6Fsfilj+A1UH0L7DL6TqQ4Bf8eYNMQT8Pm/R8Jnz/vHHsiGgmxQMe8m5Fec+KD26phwDTS20/1B3M0GGEnY2uJxEXJBIOtsEkAcBI+K7U5FT/dOTORwjgZ37bKLve6HEfm9oyVL0B3YaUHsefrCnnL7a6F+uwfFcDL0zcY8NtzdSEtoxqag4Mc7VJmJ23DS0SiO/txFitjtvcbhiaBr2f4CVhpW4t2vzu8jTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(6486002)(9686003)(82960400001)(6512007)(1076003)(6506007)(53546011)(5660300002)(186003)(316002)(66946007)(4326008)(6916009)(66476007)(66556008)(86362001)(478600001)(41300700001)(83380400001)(38100700002)(6666004)(8676002)(8936002)(107886003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZROW42YVUyL2FaNXU5SWNraXdjbWw5ZzNlWjZhYzMzbWp1Vk5NNm4zYmJa?=
 =?utf-8?B?YWcxS1BKTVg2UjJ5T0JNNGUxeHVQWno4V0p2NXBkVzBXdWRzMmFOM0wwTElm?=
 =?utf-8?B?bVZXOTJQcjdFTVBIUkxLLzhLRDdyYTNmS2FkUlJncWVRUzhsOGdOTzU0ZFR1?=
 =?utf-8?B?NFBETHJtQnJpTDQ4MlNlcE9VR3JtaUdadm9uWTg3Z1cwNXhweXRDRDFEbEZR?=
 =?utf-8?B?QXpFcW5Rc0Q3ZG1OYng0NzNvZzJQSzNVTDF0K09EdENGTWd1VWh2dTBUbnlU?=
 =?utf-8?B?akNMU1hvQmY3RkVpdGV3ckFzVmkzVmRXKzEzNy96K3FFSGQ4N3Q2TlNWbHh1?=
 =?utf-8?B?TFovMjdSaFdtemhyaGp1TWRhQWtVK3htTFV2WEhUc1dhUXBLb1VOaW90Yzlx?=
 =?utf-8?B?TUZUMWdEb1lmNFN1UDdnb25XUnpCdW9jUUo3YzJuR0VJYzJheWRPa1EzSFVJ?=
 =?utf-8?B?bnZGSXl0bXZqUmRqRmpMUURieFVKaWxyYnZURWg4RXdSVm5WR0dtOHNHZm9r?=
 =?utf-8?B?V0hyS2padFBLd3pxSTdkTU9wRjhvdVNOMzJXdnNRaDg1NURGa21nZ2FseHZJ?=
 =?utf-8?B?bGVWRmdyWTA1QnBRRm9PYkI5KzV6bktIVHR6dGcyN25WeU8wQy9Id01BUnE1?=
 =?utf-8?B?VkVtN3Q2NGNxM2l0SWpJQURIa05OODZNYUF5ajJtWm00Smw0eVVHSmNwdTFM?=
 =?utf-8?B?RkptOGNwT1Y3RURYY3BFSWV6MVFxTWc5YU40eWtORHJIR1NMaWhZT2lVTk5U?=
 =?utf-8?B?WTA0Q1NYdVlrYkhZeHhtY3Ixb3R1ZWVCZHhoaVByWWNRdmFWMURFWDNLQ0t4?=
 =?utf-8?B?UUFnSHl4RVRFc2daYW8vZnNWR1JHS0p1SDByUFdqMFFVeWFRQmwzWUtCdXhO?=
 =?utf-8?B?ZC81SXRaa21HV09FVkFBdDcyUGFkM1hWZlNBTHlEV1ByUUEwdTZnbWpWWVVP?=
 =?utf-8?B?dHJHVVBWSGI1ZWdZMC9USSs5Nzc2WWl5OER1bzFTWHdpNzhZNUhlZG9ZNXJo?=
 =?utf-8?B?U2dlaG5qeFNNUExBOS9LSGQvS242Zml2cnlBR1MvbWoxTVdOSks0SElwVDV5?=
 =?utf-8?B?bEZHV01NWVhGWklzZmUyWUJ4a1RwcHA1ZTlQQnpMekpzQWpML1JZTmF2dDhh?=
 =?utf-8?B?cHBUQkNiOE55SHpBbGMyRzV5MFo2KzR5SkhYVVR2RlpkUDg0YkN5VUkwYVRN?=
 =?utf-8?B?ZEY2WkhaZHB4anR5aUVGT3dvVFpwWHdHYTRaYzNPRVNrcnNBSkhMYjRhQk5G?=
 =?utf-8?B?NXhycXpUNVlpR3lidzFwR2NEd2hOQmVIQ0NRZmV5SVRoTW90a09ycytNcEZW?=
 =?utf-8?B?cXBPUlZSZlMzdFJUczRxeG1XdDFvaDllRTF5UVBpWkdMV3JYU1N1MmpjQ3hs?=
 =?utf-8?B?TUVVVkZ3RmhXNW0xUDRLc2g4SkpTYitDWHdvdGdqTGtXYjRGTEp3ZTQ5ZVRj?=
 =?utf-8?B?bS9lbVR2Q1N0SURJc083bGNlZWNBQVFCbFVUbTF5cEZPcWg3dmU4V0lMNWNC?=
 =?utf-8?B?ckxTR2xVdDUxY2RqSFM1a0JUSFFvdzJXWmF3QVB1UWZDdFpSZGhkOTMwQXdn?=
 =?utf-8?B?YlVOaGwrc2ptWm9uTUN4Y0p4aXB3aStmdWtwbDNneVVJWG1rdmVKMnZwZVdU?=
 =?utf-8?B?WENOU3NDWUhPOFZVT2hxTjI4UmhnQk5NSmZnSjBkaTNNQitiNHNSdUNXNXoy?=
 =?utf-8?B?VlladkttMEZiQXZWeGZpNFBtb2dYcHVTNFRwTFZ4SDg4Rm5NcnNMZU5pdTFS?=
 =?utf-8?B?WUFYcXBzVmVYcmhzazVHakorSWFPRlZLY2Y4WTU5aHJjK2IrMTVqMVBaUGM5?=
 =?utf-8?B?S2NhaHJaclNLcTFxbmhjb0kwc0NaQk5kNVQydElsV0RydmpmdUJ3dGRNUkhD?=
 =?utf-8?B?ZGx5ZzNXRklVV1E5SDlzcmsrZWNEVE9XZktoTlVTdkVPZ01iY0lOOVo1OUdm?=
 =?utf-8?B?cGFoTXgxR0tIVGZtaEpIYklzR2ZTZmN4WEM1UnNzRXcxa2o1M0xpanJkUjJW?=
 =?utf-8?B?aUc2Sk1DV202NEREdVZRd3puSk1wUDAzdURpeG44MG02OWF3S29UK2ZJWGo3?=
 =?utf-8?B?LzNsa0JONzY0L1NGb0JIb1M2c0FOaGFzZ2VhR1FxWXliZHhrbHZqZ3pIWjhJ?=
 =?utf-8?B?QmVoL1hSQVVtQVFuSGlCUGVvenB4aHZMbG5HUWR1TnVoRHNzUGFXL21ZM2hR?=
 =?utf-8?B?a1JxalN0dHdKRll2cVlmbVQzbU5MMEFvUGRzcyswcHFGU2k4enJJWUR3YURR?=
 =?utf-8?B?elpuNjByMmdjdW5tRTMzenlyNXB3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdccd41-450b-40fa-6fd9-08db60fcac92
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 10:57:34.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tYXFxWlH7FzfXEuigAj+YJfMq0wkXy6VIP4/gp5pTqy+Cti6Fh53zmZ7PzW8/krnEomleUVLjgsxoOjIXMrikupTVsC3cbsqqGCgnAGbwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 29 May 2023 15:54:36 +0200
schrieb simon.guinot@sequanux.org:

> On Mon, May 29, 2023 at 03:03:28PM +0200, Linus Walleij wrote:
> > On Mon, May 29, 2023 at 2:27=E2=80=AFPM <simon.guinot@sequanux.org> wro=
te:
> >  =20
> > > It would be nice if a pin number found in the device datasheet
> > > could still be converted into a Linux GPIO number by adding the
> > > base of the first bank. =20
> >=20
> > We actively discourage this kind of mapping because of reasons
> > stated in drivers/gpio/TODO: we want dynamic number allocation to
> > be the norm. =20
>=20
> Hi Linus,
>=20
> Sure but it would be nice to have a dynamic base applied to a
> controller (and not to each chip of this controller), and to respect
> the interval between the chips (as stated in the controllers
> datasheets).

You mentioned yourself that there are the holes to take care of. And
the symbols/names from the SPECs seem to be octal numbers to me. While
humans might prefer decimal and the code seems to be hexadecimal.

Not sure the numbers have ever been too useful for humans. And once we
change one base (bank0) we actually already break user-land that so far
failed to discover the base from sysfs (bug in that user-land code, not
our problem).

I am with Linus on that one, we should try.

Henning

> This way the assignation would be dynamic and the pin numbers found in
> controller datasheet would be meaningful as well.
>=20
> Simon

