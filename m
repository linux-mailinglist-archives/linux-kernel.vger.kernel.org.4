Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8E74FFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGLHDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjGLHDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52D136
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689145377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wufi9rv0SDzDYEN3qmZtEV5G7f/6JaOzjp0WTDKMnGU=;
        b=Yublc4idzwoLMyDkgd0h8L1ogC1qbkhBonSXyblU3lkUqxvS+9+GCEsj7fCXTEFOS6Cyq0
        5KOM2XC/gtuFko92XpF3mE1FpwdG3miko8oX6OWHOmp5fr50RFWnBSaFPEfwEPLvYKJM7m
        am8hXkuL+IGNMe05pnlgmTOEYwVfvcs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-Te2ezKgxPc-L6MyyrocdeA-1; Wed, 12 Jul 2023 03:02:53 -0400
X-MC-Unique: Te2ezKgxPc-L6MyyrocdeA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b895fa8929so70329625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689145372; x=1691737372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wufi9rv0SDzDYEN3qmZtEV5G7f/6JaOzjp0WTDKMnGU=;
        b=byTERIDzRj8/5cdB+CUx3pLJThSB73nDVnOFDwEvMSoDs3x4cNUqMqK6cyBMhQ8r9a
         AgBE4WqpGuM9qK1mL/BLhssbEUJFXyoISccBaleP2GFyJTrq1vzYDo0F7oM05soP3mby
         mKJlwRDDQVmTC7OIMXRlYYqHjiyihoxUV+4nTt1z1QNkuAuPyNcl2jPcxwlDwn0apfw1
         eP6mB47ls5TGvN8vd76C31n5GkwIkf7UqWi9JfO3Ob7BSi4PImY/2x/DAxMM9i0uSRQU
         HhBMg4eoEysrwSeJ0UTlCePT2BYmNZ2cfncddABauNGEAN4j6RmUiyMw3RF08h6K68rz
         opWA==
X-Gm-Message-State: ABy/qLZXhB7JoAySs6RfV/sJxLV1ZIemXqlmmuD/zd/ZJg61HYHU6Jv/
        SZifdqzd/hasSpay5aySePT2JhTWLKc9blpPxPVuThnM5iLPpXqrcXuX3S1I6idDfoF08MUgV2S
        FoefO4E0hZcEAx5m4DDCoU+gN
X-Received: by 2002:a17:902:f68c:b0:1b8:c1f:fcfc with SMTP id l12-20020a170902f68c00b001b80c1ffcfcmr15621563plg.11.1689145371890;
        Wed, 12 Jul 2023 00:02:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHb0dBFUiexF5mmKYCB06wLwX90g+ILyNJsPf1yZNNVkvuX1bBpUE1JjXI0J1CJtA5DWyyAeA==
X-Received: by 2002:a17:902:f68c:b0:1b8:c1f:fcfc with SMTP id l12-20020a170902f68c00b001b80c1ffcfcmr15621546plg.11.1689145371595;
        Wed, 12 Jul 2023 00:02:51 -0700 (PDT)
Received: from smtpclient.apple ([115.96.113.77])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b001b672af624esm3143511plh.164.2023.07.12.00.02.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2023 00:02:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date:   Wed, 12 Jul 2023 12:32:43 +0530
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
 <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23-May-2023, at 11:06 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
>> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
>>> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
>>>=20
>>>> Olaf, is this a reviewed-by from you? :-)
>>>=20
>>> Sorry, I did not review the new functionality, just tried to make =
sure there will be no regression for existing consumers.
>>=20
>> Okay, this is fine, too. Thank you for looking into this.
>>=20
>>=20
>>>=20
>>> Olaf
>>=20
>=20
> Gentle reminder.
>=20

I have a comment about the following change:

+		error =3D fprintf(nmfile, "\n[ipv4]\n");
+		if (error < 0)
+			goto setval_error;
+
+		if (new_val->dhcp_enabled) {
+			error =3D kvp_write_file(nmfile, "method", "", =
"auto");
+			if (error < 0)
+				goto setval_error;
+		} else {
+			error =3D kvp_write_file(nmfile, "method", "", =
"manual");
+			if (error < 0)
+				goto setval_error;
+		}

I think the method equally would apply for ipv6 as it applies for ipv4.=20=

We can use =
https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel=
/#18_Disable_IPv6_Address_for_ethernet_connection_IPV6INIT as a =
reference.=20
So setting the method should be common to both ipv4 and ipv6.

