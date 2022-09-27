Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3080C5EB6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiI0BWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiI0BWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:22:04 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E8A220D;
        Mon, 26 Sep 2022 18:22:00 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id VAW00150;
        Tue, 27 Sep 2022 09:21:50 +0800
Received: from jtjnmail201619.home.langchao.com (10.100.2.19) by
 jtjnmail201620.home.langchao.com (10.100.2.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 09:21:50 +0800
Received: from jtjnmail201619.home.langchao.com ([fe80::c426:eceb:41d0:3372])
 by jtjnmail201619.home.langchao.com ([fe80::c426:eceb:41d0:3372%2]) with mapi
 id 15.01.2507.012; Tue, 27 Sep 2022 09:21:50 +0800
From:   =?gb2312?B?dG9tb3Jyb3cgV2FuZyAozfW1wsP3KQ==?= 
        <wangdeming@inspur.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: Use filp instead of fd
Thread-Topic: [PATCH] vfio: Use filp instead of fd
Thread-Index: AdjSDqlXbkUUuQYWTu6MpzuiJRbcew==
Date:   Tue, 27 Sep 2022 01:21:50 +0000
Message-ID: <0d0817a2c6a8467e83b07c91f50511fa@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.104.82]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_002B_01D8D252.2D005F60"
MIME-Version: 1.0
tUid:   20229270921500dcc1c6b3d19c02913003bfdeeeb624b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_002B_01D8D252.2D005F60
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi

Why kvm_vfio_group_add use file.
 =20
  struct file *filp;
  .....
  filp =3D fget(fd);

  .....
  kvg->file =3D filp;
  ......
  fput(filp);

> from: Al Viro <viro@ftp.linux.org.uk> =B4=FA=B1=ED Al Viro
> time: 2022-9-22 3:38
> to: Jason Gunthorpe <jgg@nvidia.com>
> pbonzini@redhat.com; kvm@vger.kernel.org; linux-kernel@vger.kernel.org
> sub: Re: [PATCH] vfio: Use filp instead of fd
>=20
> On Mon, Sep 26, 2022 at 02:07:43PM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 26, 2022 at 02:54:07AM -0400, Deming Wang wrote:
> > > The function of kvm_vfio_group_set_spapr_tce and =
kvm_vfio_group_del
> > > use fd indirectly.But,it only be used for fd.file. So,we can
> > > directly use the struct of file instead.
> > >
> > > Signed-off-by: Deming Wang <wangdeming@inspur.com>
> > > ---
> > >  virt/kvm/vfio.c | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > I thought about changing this too when I was looking at this.
> > fdget/fdput includes a tiny micro-optimization that is legal here,
> > however I doubt anyone cares about performance on this path.
>=20
> Microoptimization or not, I'd rather keep fget() limited to cases =
where we
> really need it.  There are non-trivial cases and having them easy to =
find
is a
> good thing.
>=20
> Again, the preferred way to do descriptor lookups is fdget() family, =
not
fget()
> one.

------=_NextPart_000_002B_01D8D252.2D005F60
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AgICAIAwDgYIKoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBT2m8+B
pv3zOH+FCDvTbpfMkvPbAzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8GA1Ud
HwSCAQYwggECMIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIsQ049
Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRp
b24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9i
YXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIuaG9t
ZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEEggEb
MIIBFzCBsQYIKwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVibGlj
JTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21lLERD
PWxhbmdjaGFvLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNh
dGlvbkF1dGhvcml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8u
Y29tL0NlcnRFbnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNydDBH
BgNVHREEQDA+oCUGCisGAQQBgjcUAgOgFwwVd2FuZ2RlbWluZ0BpbnNwdXIuY29tgRV3YW5nZGVt
aW5nQGluc3B1ci5jb20wDQYJKoZIhvcNAQELBQADggEBAKD6Oh0Yu1g2xXDIaczYlx8WZiYqTi7t
bFCmsNT5DmNUfLaJre5UDyaWjgwW6Z/KN1X19Piy6oS8ex93gaeF4siDuQimREZoKxePJyUeyFs5
oC6kpsw95f/0RM5zhHb4I8L4AgplfwySCGAeMRr74rThzkYWfoU1AM+c8cBtViIispknx6KxJFo2
b533lCx168UKeNRb1n7pUANxFYd+1jjdRKCPrszdJcJddFmnLBetcnD4DG0ID62hnw+/g0KoAlfd
ORikFVBLobsDNy+NQ++5ZYgx1ahEQ6BESIjeWxut+2Zqis6Zbwd5ZsBhm892l5EdzJCuYe5xDEZw
0Z0bGvUxggOTMIIDjwIBATBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZ
FghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA
1tjc3okYpZWK7QAAAADW2DAJBgUrDgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA5MjcwMTE4NTlaMCMGCSqGSIb3DQEJBDEWBBSUPlXrBnzCZEo8
i2GkSQQz8cumWDB/BgkrBgEEAYI3EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJ
kiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BV
Ui1DQQITfgAA1tjc3okYpZWK7QAAAADW2DCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJkiaJ
k/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhv
bWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA1tjc3okYpZWK7QAAAADW2DCBkwYJKoZIhvcNAQkP
MYGFMIGCMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJ
YIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCGS6dp16jnk3ZbN6jSvQxy
0SsXcHLpNSuZZKX7130kH4INwUiZW5q0HVd+SHpUpYlVlTqqO2XNE8s6OSJR1TMz9zd+uCAES1vk
5myMuNvJApYDUMkbjmwhQ17+HqoKpGxah2HgpICYO/eXUbPJhwm8CRyitY0K1wSNM4ttM9JubpMD
NrkylISJ9pnkJpl/DuBfXBRn+PWOU/8cm8kfxRfKd87QECQ5Jvsd82gBdtM1wpwH0BBt2kUdW9HW
WzEyHwXkt+4a4Jz1iqT5a8ebJu10dpQ4w/XFK8n2QV7lbVzJPbmPDMkGAx+GqDymrg8eZmPLRkRA
lkey8wtd85Poy0SgAAAAAAAA

------=_NextPart_000_002B_01D8D252.2D005F60--
