Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498145FE65F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJNAkE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Oct 2022 20:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJNAkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:40:02 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCA43204D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:39:59 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 598C1AB1D6;
        Fri, 14 Oct 2022 00:39:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 3B9C320026;
        Fri, 14 Oct 2022 00:39:43 +0000 (UTC)
Message-ID: <741eb1fe7101850d9e75cb5ef29d7b4e5376e475.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add the --for-tree argument
From:   Joe Perches <joe@perches.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 13 Oct 2022 17:39:53 -0700
In-Reply-To: <20221013215738.32326-1-palmer@rivosinc.com>
References: <20221013215738.32326-1-palmer@rivosinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: gy5g474zhmo8kmoac9nu6e99wwhffbzw
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3B9C320026
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX195Ynfd/ZtrySUbqgWu7NjYP6hY0SOZoH4=
X-HE-Tag: 1665707983-79577
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-13 at 14:57 -0700, Palmer Dabbelt wrote:
> I recently wanted to look up the maintainers for each tree path via a
> script, and I couldn't find a better way to do that than poking
> get_maintainer.pl to add a new argument.  This lets folks run something
> like
> 
>     $ ./scripts/get_maintainer.pl --for-tree git://github.com/kvm-riscv/linux.git
>     Anup Patel <anup@brainfault.org> (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
>     kvm@vger.kernel.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
>     kvm-riscv@lists.infradead.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
>     linux-riscv@lists.infradead.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
> 
> to find out who owns a tree.

I'm not sure this is useful.

It seems far simpler to grep the MAINTAINERS file for the repository.

And:

$ git grep "^T:" MAINTAINERS | sort | uniq -c | sort -rn | head -10
    153 MAINTAINERS:T:	git git://linuxtv.org/media_tree.git
     70 MAINTAINERS:T:	git git://anongit.freedesktop.org/drm/drm-misc
     33 MAINTAINERS:T:	git git://linuxtv.org/anttip/media_tree.git
      9 MAINTAINERS:T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
      6 MAINTAINERS:T:	git git://linuxtv.org/mkrufky/tuners.git
      6 MAINTAINERS:T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
      6 MAINTAINERS:T:	git git://github.com/broadcom/stblinux.git
      5 MAINTAINERS:T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
      5 MAINTAINERS:T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
      5 MAINTAINERS:T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev

I think I would not like to see the output for git repositories
with 153 matches. (or even 5 matches)

For instance: (I've more comments below this too)

$ ./scripts/get_maintainer.pl --for-tree=git://linuxtv.org/media_tree.git
Hans Verkuil <hverkuil@xs4all.nl> (maintainer:AIMSLAB FM RADIO RECEIVER DRIVER)
linux-media@vger.kernel.org (maintainer:AIMSLAB FM RADIO RECEIVER DRIVER)
Maxime Ripard <mripard@kernel.org> (maintainer:ALLWINNER A10 CSI DRIVER)
Paul Kocialkowski <paul.kocialkowski@bootlin.com> (maintainer:ALLWINNER A31 MIPI CSI-2 BRIDGE DRIVER)
Tianshu Qiu <tian.shu.qiu@intel.com> (maintainer:ASAHI KASEI AK7375 LENS VOICE COIL DRIVER)
Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:AZ6007 DVB DRIVER)
Fabien Dessenne <fabien.dessenne@foss.st.com> (supporter:BDISP ST MEDIA DRIVER)
Joe Tessler <jrt@google.com> (maintainer:CHRONTEL CH7322 CEC DRIVER)
Yong Deng <yong.deng@magewell.com> (maintainer:CSI DRIVERS FOR ALLWINNER V3s)
Andy Walls <awalls@md.metrocast.net> (maintainer:CX18 VIDEO4LINUX DRIVER)
Jernej Skrabec <jernej.skrabec@gmail.com> (maintainer:DEINTERLACE DRIVERS FOR ALLWINNER H3)
Hugues Fruchet <hugues.fruchet@foss.st.com> (supporter:DELTA ST MEDIA DRIVER)
Sakari Ailus <sakari.ailus@linux.intel.com> (maintainer:DONGWOON DW9714 LENS VOICE COIL DRIVER)
Dongchun Zhu <dongchun.zhu@mediatek.com> (maintainer:DONGWOON DW9768 LENS VOICE COIL DRIVER)
Alexey Klimov <klimov.linux@gmail.com> (maintainer:DSBR100 USB FM RADIO DRIVER)
Michael Krufky <mkrufky@linuxtv.org> (maintainer:DVB_USB_CXUSB MEDIA DRIVER)
Charles-Antoine Couret <charles-antoine.couret@nexvision.fr> (maintainer:GS1662 VIDEO SERIALIZER)
Frank Zago <frank@zago.net> (maintainer:GSPCA FINEPIX SUBDRIVER)
Olivier Lorin <o.lorin@laposte.net> (maintainer:GSPCA GL860 SUBDRIVER)
Erik Andren <erik.andren@gmail.com> (maintainer:GSPCA M5602 SUBDRIVER)
Brian Johnson <brijohn@gmail.com> (maintainer:GSPCA SN9C20X SUBDRIVER)
Leandro Costantino <lcostantino@gmail.com> (maintainer:GSPCA T613 SUBDRIVER)
Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com> (supporter:HVA ST MEDIA DRIVER)
Shawn Tu <shawnx.tu@intel.com> (maintainer:HYNIX HI556 SENSOR DRIVER)
Yong Zhi <yong.zhi@intel.com> (maintainer:INTEL IPU3 CSI-2 CIO2 DRIVER)
Bingbu Cao <bingbu.cao@intel.com> (maintainer:INTEL IPU3 CSI-2 CIO2 DRIVER)
Dan Scally <djrscally@gmail.com> (maintainer:INTEL IPU3 CSI-2 CIO2 DRIVER)
Ramesh Shanmugasundaram <rashanmu@gmail.com> (maintainer:MAX2175 SDR TUNER DRIVER)
Laurent Pinchart <laurent.pinchart@ideasonboard.com> (supporter:MEDIA CONTROLLER FRAMEWORK)
Philipp Zabel <p.zabel@pengutronix.de> (maintainer:MEDIA DRIVER FOR FREESCALE IMX PXP)
Sergey Kozlov <serjk@netup.ru> (supporter:MEDIA DRIVERS FOR ASCOT2E)
Abylay Ospan <aospan@netup.ru> (supporter:MEDIA DRIVERS FOR ASCOT2E)
Jasmin Jessich <jasmin@anw.at> (maintainer:MEDIA DRIVERS FOR CXD2099AR CI CONTROLLERS)
Yasunari Takiguchi <Yasunari.Takiguchi@sony.com> (supporter:MEDIA DRIVERS FOR CXD2880)
Steve Longerbeam <slongerbeam@gmail.com> (maintainer:MEDIA DRIVERS FOR FREESCALE IMX)
Rui Miguel Silva <rmfrfs@gmail.com> (maintainer:MEDIA DRIVERS FOR FREESCALE IMX7)
Dmitry Osipenko <digetx@gmail.com> (maintainer:MEDIA DRIVERS FOR NVIDIA TEGRA - VDE)
linux-tegra@vger.kernel.org (maintainer:MEDIA DRIVERS FOR NVIDIA TEGRA - VDE)
Jacopo Mondi <jacopo@jmondi.org> (supporter:MEDIA DRIVERS FOR RENESAS - CEU)
linux-renesas-soc@vger.kernel.org (supporter:MEDIA DRIVERS FOR RENESAS - CEU)
Fabrizio Castro <fabrizio.castro.jz@renesas.com> (supporter:MEDIA DRIVERS FOR RENESAS - DRIF)
Kieran Bingham <kieran.bingham+renesas@ideasonboard.com> (supporter:MEDIA DRIVERS FOR RENESAS - FDP1)
"Niklas Söderlund" <niklas.soderlund@ragnatech.se> (supporter:MEDIA DRIVERS FOR RENESAS - VIN)
Neil Armstrong <neil.armstrong@linaro.org> (supporter:MESON AO CEC DRIVER FOR AMLOGIC SOCS)
linux-amlogic@lists.infradead.org (supporter:MESON AO CEC DRIVER FOR AMLOGIC SOCS)
Jimmy Su <jimmy.su@intel.com> (maintainer:OMNIVISION OV08D10 SENSOR DRIVER)
Arec Kao <arec.kao@intel.com> (maintainer:OMNIVISION OV13B10 SENSOR DRIVER)
Shunqian Zheng <zhengsq@rock-chips.com> (maintainer:OMNIVISION OV2685 SENSOR DRIVER)
Dave Stevenson <dave.stevenson@raspberrypi.com> (maintainer:OMNIVISION OV5647 SENSOR DRIVER)
Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com> (maintainer:OMNIVISION OV5670 SENSOR DRIVER)
Wenyou Yang <wenyou.yang@microchip.com> (maintainer:OMNIVISION OV7740 SENSOR DRIVER)
"Paul J. Murphy" <paul.j.murphy@intel.com> (maintainer:OMNIVISION OV9282 SENSOR DRIVER)
Daniele Alessandrelli <daniele.alessandrelli@intel.com> (maintainer:OMNIVISION OV9282 SENSOR DRIVER)
Mike Isely <isely@pobox.com> (maintainer:PVRUSB2 VIDEO4LINUX DRIVER)
pvrusb2@isely.net (maintainer:PVRUSB2 VIDEO4LINUX DRIVER)
Stanimir Varbanov <stanimir.varbanov@linaro.org> (maintainer:QUALCOMM VENUS VIDEO ACCELERATOR DRIVER)
linux-arm-msm@vger.kernel.org (maintainer:QUALCOMM VENUS VIDEO ACCELERATOR DRIVER)
Sean Young <sean@mess.org> (maintainer:RC-CORE / LIRC FRAMEWORK)
Eduardo Valentin <edubezval@gmail.com> (odd fixer:SI4713 FM RADIO TRANSMITTER I2C DRIVER)
Ricardo Ribalda <ribalda@kernel.org> (maintainer:SONY IMX214 SENSOR DRIVER)
Leon Luo <leonl@leopardimaging.com> (maintainer:SONY IMX274 SENSOR DRIVER)
Manivannan Sadhasivam <mani@kernel.org> (maintainer:SONY IMX290 SENSOR DRIVER)
Benjamin Mugnier <benjamin.mugnier@foss.st.com> (maintainer:ST MIPID02 CSI-2 TO PARALLEL BRIDGE DRIVER)
Sylvain Petinot <sylvain.petinot@foss.st.com> (maintainer:ST MIPID02 CSI-2 TO PARALLEL BRIDGE DRIVER)
Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> (maintainer:STK1160 USB VIDEO CAPTURE DRIVER)
Olli Salonen <olli.salonen@iki.fi> (maintainer:TDA18250 MEDIA DRIVER)
Antoine Jacquet <royale@zerezo.com> (maintainer:USB ZR364XX DRIVER)
linux-usb@vger.kernel.org (maintainer:USB ZR364XX DRIVER)
Shuah Khan <skhan@linuxfoundation.org> (maintainer:VIMC VIRTUAL MEDIA CONTROLLER DRIVER)
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> (maintainer:VIDTV VIRTUAL DIGITAL TV DRIVER)
Hyun Kwon <hyun.kwon@xilinx.com> (supporter:XILINX VIDEO IP CORES)

And I don't know how this is an improvement as the --for-tree argument
seems _very_ likely to be typoed.

> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> @@ -23,6 +23,7 @@ use File::Spec::Functions;
>  
>  my $cur_path = fastgetcwd() . '/';
>  my $lk_path = "./";
> +my $for_tree = undef;
>  my $email = 1;
>  my $email_usename = 1;
>  my $email_maintainer = 1;
> @@ -239,6 +240,7 @@ if ($#ARGV > 0) {
>  
>  if (!GetOptions(
>  		'email!' => \$email,
> +		'for-tree=s' => \$for_tree,
>  		'git!' => \$email_git,
>  		'git-all-signature-types!' => \$email_git_all_signature_types,
>  		'git-blame!' => \$email_git_blame,
> @@ -300,7 +302,7 @@ if (defined $self_test) {
>      exit 0;
>  }
>  
> -if (-t STDIN && !@ARGV) {
> +if (-t STDIN && !@ARGV && !$for_tree) {
>      # We're talking to a terminal, but have no command line arguments.
>      die "$P: missing patchfile or -f file - use --help if necessary\n";
>  }
> @@ -527,7 +529,7 @@ sub read_mailmap {
>  
>  ## use the filenames on the command line or find the filenames in the patchfiles
>  
> -if (!@ARGV) {
> +if (!@ARGV && !$for_tree) {
>      push(@ARGV, "&STDIN");
>  }
>  
> @@ -951,6 +953,47 @@ sub get_maintainers {
>  	}
>      }
>  
> +    if ($for_tree) {
> +        my $tvi = find_first_section();
> +        while ($tvi < @typevalue) {
> +            my $start = find_starting_index($tvi);
> +            my $end = find_ending_index($tvi);
> +            $tvi = $end + 1;
> +
> +            my $i;
> +            my $tree_match = 0;
> +            for ($i = $start; $i < $end; $i++) {
> +                my $line = $typevalue[$i];
> +                if ($line =~ m/^([A-Z]):(.*)/) {
> +                    my $type = $1;
> +                    my $value = $2;
> +
> +                    if ($type eq 'T') {
> +                        if ($for_tree eq $value || "git $for_tree" eq $value) {
> +                            $tree_match = 1
> +                        }
> +                    }
> +                }
> +            }
> +
> +            if ($tree_match) {
> +                for ($i = $start; $i < $end; $i++) {
> +                    my $line = $typevalue[$i];
> +                    if ($line =~ m/^([A-Z]):(.*)/) {
> +                        my $type = $1;
> +                        my $value = $2;
> +
> +                        if ($type eq 'M' || $type eq 'L') {

And what about reviewers? 'R' ?

> +                            my $role = get_maintainer_role($i);

Also this improperly marks mailing lists as "maintainer:<SECTION>"
rather than "mailing list:<SECTION>" as it uses the S: value for
the section rather than the actual role of the person.

> +                            push_email_address($value, $role)
> +                        }
> +                    }
> +                }
> +            }
> +        }
> +    }
> +
> +
>      foreach my $email (@email_to, @list_to) {
>  	$email->[0] = deduplicate_email($email->[0]);
>      }
> @@ -1074,6 +1117,7 @@ Output type options:
>    --multiline => print 1 entry per line
>  
>  Other options:
> +  --for-tree => Get maintainers for the given tree
>    --pattern-depth => Number of pattern directory traversals (default: 0 (all))
>    --keywords => scan patch for keywords (default: $keywords)
>    --sections => print all of the subsystem sections with pattern matches

