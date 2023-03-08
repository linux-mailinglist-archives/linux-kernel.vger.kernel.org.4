Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0F6B03A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCHKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCHKDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:03:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F31CF45
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:03:07 -0800 (PST)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 52E863F828
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678269786;
        bh=TcoqL65GM7xxmY0Iiy4skPLD0tnvFATDCwzBl50q5+I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Detcu/W1H/u66gtLzFKJ3OwXxNZAYTNW5tTCYi+Xu6Jl+THS3kklSPPSfcTgx9HJE
         n7u2FSC/IR58we9/yISPut0h5IIhI1oVwkTs8LFR6O+4mrmMv28iD7Dcr703lhJd1K
         4D84Zmc9IYQ6RgGAiMaI85/LwadfvcF4K3/rWEtfBHGEOL5CU3CFqJ9nfco+7RIfk+
         9U7MSwTKfAoVEYYSC0+mLVGfiKwvFMdUTTtf2GbRzkVW0PhY75dOGZbT4pV6+LXBzP
         etPF1MGmKqqxPlLBLYQP0R8cnbJvSNjYG3fne3Hcy5e4RR4ht6qFZrxnr7r902rmq+
         LcFrP5bZyFXvQ==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-176347f3b28so9790204fac.23
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcoqL65GM7xxmY0Iiy4skPLD0tnvFATDCwzBl50q5+I=;
        b=7w4K3a1TGroA5N95DRilEO5HQv6G2SS88B895kVcxpFaVNpSJR5C3EHCiITLBw/3jS
         5JPwlhIUltWrtqTd1zwqsFsqLMh1v32vjmG+KukvJhCbhyqJWHUOIcOJyA+m0DTSUTRX
         3xrUCRDWy364gvtqZQx/hjM0ZwES5mcVCURTRvPrztLqPCP0pTGYCioyiyu6YAV8RZxm
         kY2ihwHTUPgSyCpjF59xMrhDfKAdWPSR4c5gb/TjM4U2+ep1Ln5rE+atx4GpJtNsV3IG
         tT7sexgq4rGyqcRN5c3e2hD8S9G5Iitz3zqJ0wTsa8zq45w127NjDiRPldd6ZDCFgh6H
         AC1w==
X-Gm-Message-State: AO0yUKV1t5/Ivf+Wp97m43n4urIbA8ppN7fep/KiaKi0ToXwMLaB2NWN
        rPpIFaq1ew4z5U9gEv22sl9gmSJoLXNRjRgeJ8aDy0A9bdXaLLMkiF8PPMQbe2Hqi9UK6nCkZFc
        sUcfDNT59iEgF00CI18GYUH3Qz6uXlTy4yN6Jig3ZkOuQbRzsWVsAUHiI
X-Received: by 2002:a05:6870:d346:b0:176:42a5:a544 with SMTP id h6-20020a056870d34600b0017642a5a544mr5041318oag.2.1678269785263;
        Wed, 08 Mar 2023 02:03:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/rrxkpYmldQbkjsH+aqtmbvnADinYJ3IA6vjRlLPTAKktc6w1MXBujxHZsR32pBxuvK3COpwN6xQq6zhKYfmk=
X-Received: by 2002:a05:6870:d346:b0:176:42a5:a544 with SMTP id
 h6-20020a056870d34600b0017642a5a544mr5041308oag.2.1678269784978; Wed, 08 Mar
 2023 02:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20230307150030.527726-1-po-hsu.lin@canonical.com> <20230307170219.4699af9b@kernel.org>
In-Reply-To: <20230307170219.4699af9b@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Wed, 8 Mar 2023 18:02:26 +0800
Message-ID: <CAMy_GT8fdX2uUAM1j9Lzje+K5BnLH82dmx3CE=mGV9UqSRBWAg@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: net: devlink_port_split.py: skip test if no
 suitable device available
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, idosch@mellanox.com,
        danieller@mellanox.com, petrm@mellanox.com, shuah@kernel.org,
        pabeni@redhat.com, edumazet@google.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 9:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  7 Mar 2023 23:00:30 +0800 Po-Hsu Lin wrote:
> > The `devlink -j port show` command output may not contain the "flavour"
> > key, an example from s390x LPAR with Ubuntu 22.10 (5.19.0-37-generic),
> > iproute2-5.15.0:
> >   {"port":{"pci/0001:00:00.0/1":{"type":"eth","netdev":"ens301"},
> >            "pci/0001:00:00.0/2":{"type":"eth","netdev":"ens301d1"},
> >            "pci/0002:00:00.0/1":{"type":"eth","netdev":"ens317"},
> >            "pci/0002:00:00.0/2":{"type":"eth","netdev":"ens317d1"}}}
> >
> > This will cause a KeyError exception.
>
> I looked closer and I don't understand why the key is not there.
> Both 5.19 kernel should always put this argument out, and 5.15
> iproute2 should always interpret it.
>
> Am I looking wrong? Do you see how we can get a dump with no flavor?
>
> I worry that this is some endianness problem, and we just misreport
> stuff on big-endian.
>
> > Create a validate_devlink_output() to check for this "flavour" from
> > devlink command output to avoid this KeyError exception. Also let
> > it handle the check for `devlink -j dev show` output in main().
> >
> > Apart from this, if the test was not started because of any reason
> > (e.g. "lanes" does not exist, max lanes is 0 or the flavour of the
> > designated device is not "physical" and etc.) The script will still
> > return 0 and thus causing a false-negative test result.
> >
> > Use a test_ran flag to determine if these tests were skipped and
> > return KSFT_SKIP to make it more clear.
> >
> > V2: factor out the skip logic from main(), update commit message and
> >     skip reasons accordingly.
> > Link: https://bugs.launchpad.net/bugs/1937133
> > Fixes: f3348a82e727 ("selftests: net: Add port split test")
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >  tools/testing/selftests/net/devlink_port_split.py | 36 +++++++++++++++=
++++----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/devlink_port_split.py b/tools/=
testing/selftests/net/devlink_port_split.py
> > index 2b5d6ff..749606c 100755
> > --- a/tools/testing/selftests/net/devlink_port_split.py
> > +++ b/tools/testing/selftests/net/devlink_port_split.py
> > @@ -59,6 +59,8 @@ class devlink_ports(object):
> >          assert stderr =3D=3D ""
> >          ports =3D json.loads(stdout)['port']
> >
> > +        validate_devlink_output(ports, 'flavour')
>
> If it's just a matter of kernel/iproute2 version we shouldn't need to
> check here again?
>
> >          for port in ports:
> >              if dev in port:
> >                  if ports[port]['flavour'] =3D=3D 'physical':
> > @@ -220,6 +222,27 @@ def split_splittable_port(port, k, lanes, dev):
> >      unsplit(port.bus_info)
> >
> >
> > +def validate_devlink_output(devlink_data, target_property=3DNone):
> > +    """
> > +    Determine if test should be skipped by checking:
> > +      1. devlink_data contains values
> > +      2. The target_property exist in devlink_data
> > +    """
> > +    skip_reason =3D None
> > +    if any(devlink_data.values()):
> > +        if target_property:
> > +            skip_reason =3D "{} not found in devlink output, test skip=
ped".format(target_property)
> > +            for key in devlink_data:
> > +                if target_property in devlink_data[key]:
> > +                    skip_reason =3D None
> > +    else:
> > +        skip_reason =3D 'devlink output is empty, test skipped'
> > +
> > +    if skip_reason:
> > +        print(skip_reason)
> > +        sys.exit(KSFT_SKIP)
>
> Looks good, so..
>
> >  def make_parser():
> >      parser =3D argparse.ArgumentParser(description=3D'A test for port =
splitting.')
> >      parser.add_argument('--dev',
> > @@ -231,6 +254,7 @@ def make_parser():
> >
> >
> >  def main(cmdline=3DNone):
> > +    test_ran =3D False
>
> I don't think we need the test_ran tracking any more?
We still need this here to check if the test was actually started.

Take the following output for example (ARM64 server with Mellanox
Ethernet controller, running Ubuntu 22.10 5.19.0-35):
$ devlink port show
pci/0000:01:00.0/65535: type eth netdev enp1s0f0 flavour physical port
0 splittable false
pci/0000:01:00.1/131071: type eth netdev enp1s0f1 flavour physical
port 1 splittable false
There is no "lanes" attribute here, thus the max_lanes in main() will
be 0. The test won't be started at all but returns 0.


>
> >      parser =3D make_parser()
> >      args =3D parser.parse_args(cmdline)
> >
> > @@ -240,12 +264,9 @@ def main(cmdline=3DNone):
> >          stdout, stderr =3D run_command(cmd)
> >          assert stderr =3D=3D ""
> >
> > +        validate_devlink_output(json.loads(stdout))
> >          devs =3D json.loads(stdout)['dev']
> > -        if devs:
> > -            dev =3D list(devs.keys())[0]
> > -        else:
> > -            print("no devlink device was found, test skipped")
> > -            sys.exit(KSFT_SKIP)
> > +        dev =3D list(devs.keys())[0]
> >
> >      cmd =3D "devlink dev show %s" % dev
> >      stdout, stderr =3D run_command(cmd)
> > @@ -277,6 +298,11 @@ def main(cmdline=3DNone):
> >                  split_splittable_port(port, lane, max_lanes, dev)
> >
> >                  lane //=3D 2
> > +        test_ran =3D True
> > +
> > +    if not test_ran:
> > +        print("Test not started, no suitable device for the test")
> > +        sys.exit(KSFT_SKIP)
> >
> >
> >  if __name__ =3D=3D "__main__":
>
