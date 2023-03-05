Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759946AB134
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCEPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCEPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:12:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F1166DC;
        Sun,  5 Mar 2023 07:12:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5ED5EB80A09;
        Sun,  5 Mar 2023 15:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214C8C433D2;
        Sun,  5 Mar 2023 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678029140;
        bh=LBr/n+ttvtaLrM/YsYzsvXTjGvgOiRdzRyUXGpZm9vQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gj9yJNKU1NZ2c98JUzJJMjaJK9H0EFeAfCw7HogpbqOQ4e7gowgXERhhW1IgmydIv
         Msj/mncKaDnOD/gmtnGe86Jd/WSeZX36/XEeKlF5wzqddpAO6HKTBNfpHYRQjgZV0T
         d7VUNK/cX9ViqF9NUl4EXO0CGMN0PrfWLixkNY7NSvS1Y5COLLbQuGtVrIsDKB5Oiz
         fev65ed/uWxoT+IQWp3QzLebG8hUUlDyfdohYhvGN+GCLxwtqhRDNs1ohB6f3SUx6e
         P8+noN2x+0fD7QCVeeM8XijRhmlBku+ZnYlXe7oHyRAPTioSoba1JYxwDQyV7vSdS6
         83OXC18InUvkg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17235c8dab9so8780816fac.7;
        Sun, 05 Mar 2023 07:12:20 -0800 (PST)
X-Gm-Message-State: AO0yUKV5Hltcvh5UaNSSTEcCxz3u1069tae/ciRbViPJBdpF9aXHMlhl
        qEsQHCyOaHVpb9IaKrJL+QHklDt+NnCapXuwkq0=
X-Google-Smtp-Source: AK7set8hnKqOA7s6d55PoongLJOxWG2hRHAcLvYKVgSRdujJziuYPyuuYLc8QlmZHXBqNsUhTzNd/cAE6dsMH73oj0s=
X-Received: by 2002:a05:6871:6a81:b0:176:3e60:3269 with SMTP id
 zf1-20020a0568716a8100b001763e603269mr2638995oab.8.1678029139325; Sun, 05 Mar
 2023 07:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20221205163157.269335-1-nick.alcock@oracle.com> <20221205163157.269335-5-nick.alcock@oracle.com>
In-Reply-To: <20221205163157.269335-5-nick.alcock@oracle.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 6 Mar 2023 00:11:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASetZNfww0QbwuVnp1QU6+LaUeSR3nj-+bQi1kM+mgLdg@mail.gmail.com>
Message-ID: <CAK7LNASetZNfww0QbwuVnp1QU6+LaUeSR3nj-+bQi1kM+mgLdg@mail.gmail.com>
Subject: Re: [PATCH v10 04/13] kbuild: fix up substitutions in makefiles to
 allow for tristate checker
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 1:32=E2=80=AFAM Nick Alcock <nick.alcock@oracle.com>=
 wrote:
>
> The tristate checker, like the Makefile.modbuiltin that preceded it,
> relies on running the makefiles with some CONFIG_ variables set to
> uppercase values ('Y' or 'M').  Large portions of the core build system
> assume that these values are lowercase, but we mostly don't care about
> those because they are only involved in actual building, and make
> tristatecheck doesn't build anything (the parts that do need changing so
> that recursion etc still worked were changed as part of the tristate
> commit).
>
> But some makefiles that are not part of the core build system also
> contain assumptions that CONFIG_ variables are always lowercase (every
> one of these was also broken wrt the old modules.builtin machinery, but
> now this is part of a verifier, the problems are more obvious).  In most
> cases this is just something like
>
> obj-$(subst m,y,$(CONFIG_FOO)) +=3D blah.o
>
> to indicate that blah.o is always built in even if CONFIG_FOO is a
> module.  There is a new macro to help this relatively common case, which
> should now be rewritten as
>
> obj-$(call always_built_in,$(CONFIG_FOO)) +=3D blah.o
>
> One other case we handle is that in net/dccp where things are built as
> modules iff any member of some other set are modular; this is now
> handled like so:
>
> obj-$(call module_if_any_modular,$(CONFIG_IP_DCCP)$(CONFIG_IPV6)) +=3D dc=
cp_ipv6.o
> dccp_ipv6-$(call module_if_any_modular,$(CONFIG_IP_DCCP)$(CONFIG_IPV6)) :=
=3D ipv6.o
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>



The tristate checker in the previous commit is so ugly
and should not exist in the upstream.

So, this patch will just introduce lots of ugliness for no good reason.

NACK.






> ---
>
> Notes:
>     v10: new.
>
>  drivers/Makefile                         |  2 +-
>  drivers/hv/Makefile                      |  2 +-
>  drivers/mmc/Makefile                     |  2 +-
>  drivers/net/wireless/silabs/wfx/Makefile |  2 +-
>  drivers/s390/char/Makefile               |  2 +-
>  drivers/s390/crypto/Makefile             |  2 +-
>  net/8021q/Makefile                       |  2 +-
>  net/Makefile                             |  2 +-
>  net/bridge/Makefile                      |  4 ++--
>  net/dccp/Makefile                        |  4 ++--
>  net/ipv6/Makefile                        |  2 +-
>  net/l2tp/Makefile                        | 12 ++++++------
>  net/netfilter/Makefile                   |  2 +-
>  net/netlabel/Makefile                    |  2 +-
>  net/sctp/Makefile                        |  2 +-
>  scripts/Kbuild.include                   | 15 +++++++++++++++
>  16 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index bdf1c66141c9..a6d3296f0c23 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -159,7 +159,7 @@ obj-$(CONFIG_SOUNDWIRE)             +=3D soundwire/
>
>  # Virtualization drivers
>  obj-$(CONFIG_VIRT_DRIVERS)     +=3D virt/
> -obj-$(subst m,y,$(CONFIG_HYPERV))      +=3D hv/
> +obj-$(call always_built_in,$(CONFIG_HYPERV))   +=3D hv/
>
>  obj-$(CONFIG_PM_DEVFREQ)       +=3D devfreq/
>  obj-$(CONFIG_EXTCON)           +=3D extcon/
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index d76df5c8c2a9..06777af02a78 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -13,4 +13,4 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)     +=3D hv_debugfs.o
>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_tra=
nsport.o
>
>  # Code that must be built-in
> -obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
> +obj-$(call always_built_in,$(CONFIG_HYPERV)) +=3D hv_common.o
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index 3ea0126a9a72..1f4f9ce02490 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -4,4 +4,4 @@
>  #
>
>  obj-$(CONFIG_MMC)              +=3D core/
> -obj-$(subst m,y,$(CONFIG_MMC)) +=3D host/
> +obj-$(call always_built_in,$(CONFIG_MMC))      +=3D host/
> diff --git a/drivers/net/wireless/silabs/wfx/Makefile b/drivers/net/wirel=
ess/silabs/wfx/Makefile
> index c8b356f71c99..9fe47f5a050a 100644
> --- a/drivers/net/wireless/silabs/wfx/Makefile
> +++ b/drivers/net/wireless/silabs/wfx/Makefile
> @@ -20,6 +20,6 @@ wfx-y :=3D \
>         debug.o
>  wfx-$(CONFIG_SPI) +=3D bus_spi.o
>  # When CONFIG_MMC =3D=3D m, append to 'wfx-y' (and not to 'wfx-m')
> -wfx-$(subst m,y,$(CONFIG_MMC)) +=3D bus_sdio.o
> +wfx-$(call always_built_in,$(CONFIG_MMC)) +=3D bus_sdio.o
>
>  obj-$(CONFIG_WFX) +=3D wfx.o
> diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
> index ce32270082f5..d21086e99528 100644
> --- a/drivers/s390/char/Makefile
> +++ b/drivers/s390/char/Makefile
> @@ -34,7 +34,7 @@ obj-$(CONFIG_SCLP_VT220_TTY) +=3D sclp_vt220.o
>
>  obj-$(CONFIG_PCI) +=3D sclp_pci.o
>
> -obj-$(subst m,y,$(CONFIG_ZCRYPT)) +=3D sclp_ap.o
> +obj-$(call always_built_in,$(CONFIG_ZCRYPT)) +=3D sclp_ap.o
>
>  obj-$(CONFIG_VMLOGRDR) +=3D vmlogrdr.o
>  obj-$(CONFIG_VMCP) +=3D vmcp.o
> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
> index 22d2db690cd3..e3594486d8f3 100644
> --- a/drivers/s390/crypto/Makefile
> +++ b/drivers/s390/crypto/Makefile
> @@ -4,7 +4,7 @@
>  #
>
>  ap-objs :=3D ap_bus.o ap_card.o ap_queue.o
> -obj-$(subst m,y,$(CONFIG_ZCRYPT)) +=3D ap.o
> +obj-$(call always_built_in,$(CONFIG_ZCRYPT)) +=3D ap.o
>  # zcrypt_api.o and zcrypt_msgtype*.o depend on ap.o
>  zcrypt-objs :=3D zcrypt_api.o zcrypt_card.o zcrypt_queue.o
>  zcrypt-objs +=3D zcrypt_msgtype6.o zcrypt_msgtype50.o
> diff --git a/net/8021q/Makefile b/net/8021q/Makefile
> index e05d4d7aab35..50b48af58322 100644
> --- a/net/8021q/Makefile
> +++ b/net/8021q/Makefile
> @@ -2,7 +2,7 @@
>  #
>  # Makefile for the Linux VLAN layer.
>  #
> -obj-$(subst m,y,$(CONFIG_VLAN_8021Q))  +=3D vlan_core.o
> +obj-$(call always_built_in,$(CONFIG_VLAN_8021Q))       +=3D vlan_core.o
>  obj-$(CONFIG_VLAN_8021Q)               +=3D 8021q.o
>
>  8021q-y                                        :=3D vlan.o vlan_dev.o vl=
an_netlink.o
> diff --git a/net/Makefile b/net/Makefile
> index 6a62e5b27378..94165eb38b65 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -42,7 +42,7 @@ obj-$(CONFIG_PHONET)          +=3D phonet/
>  ifneq ($(CONFIG_VLAN_8021Q),)
>  obj-y                          +=3D 8021q/
>  endif
> -obj-$(CONFIG_IP_DCCP)          +=3D dccp/
> +obj-$(call always_built_in,$(CONFIG_IP_DCCP)) +=3D dccp/
>  obj-$(CONFIG_IP_SCTP)          +=3D sctp/
>  obj-$(CONFIG_RDS)              +=3D rds/
>  obj-$(CONFIG_WIRELESS)         +=3D wireless/
> diff --git a/net/bridge/Makefile b/net/bridge/Makefile
> index 24bd1c0a9a5a..4f3109e170c8 100644
> --- a/net/bridge/Makefile
> +++ b/net/bridge/Makefile
> @@ -12,10 +12,10 @@ bridge-y    :=3D br.o br_device.o br_fdb.o br_forward=
.o br_if.o br_input.o \
>
>  bridge-$(CONFIG_SYSFS) +=3D br_sysfs_if.o br_sysfs_br.o
>
> -bridge-$(subst m,y,$(CONFIG_BRIDGE_NETFILTER)) +=3D br_nf_core.o
> +bridge-$(call always_built_in,$(CONFIG_BRIDGE_NETFILTER)) +=3D br_nf_cor=
e.o
>
>  br_netfilter-y :=3D br_netfilter_hooks.o
> -br_netfilter-$(subst m,y,$(CONFIG_IPV6)) +=3D br_netfilter_ipv6.o
> +br_netfilter-$(call always_built_in,$(CONFIG_IPV6)) +=3D br_netfilter_ip=
v6.o
>  obj-$(CONFIG_BRIDGE_NETFILTER) +=3D br_netfilter.o
>
>  bridge-$(CONFIG_BRIDGE_IGMP_SNOOPING) +=3D br_multicast.o br_mdb.o br_mu=
lticast_eht.o
> diff --git a/net/dccp/Makefile b/net/dccp/Makefile
> index 5b4ff37bc806..607f6d3dd795 100644
> --- a/net/dccp/Makefile
> +++ b/net/dccp/Makefile
> @@ -17,8 +17,8 @@ dccp-$(CONFIG_IP_DCCP_TFRC_LIB) +=3D ccids/lib/tfrc.o  =
         \
>  dccp_ipv4-y :=3D ipv4.o
>
>  # build dccp_ipv6 as module whenever either IPv6 or DCCP is a module
> -obj-$(subst y,$(CONFIG_IP_DCCP),$(CONFIG_IPV6)) +=3D dccp_ipv6.o
> -dccp_ipv6-y :=3D ipv6.o
> +obj-$(call module_if_any_modular,$(CONFIG_IP_DCCP)$(CONFIG_IPV6)) +=3D d=
ccp_ipv6.o
> +dccp_ipv6-$(call module_if_any_modular,$(CONFIG_IP_DCCP)$(CONFIG_IPV6)) =
:=3D ipv6.o
>
>  obj-$(CONFIG_INET_DCCP_DIAG) +=3D dccp_diag.o
>
> diff --git a/net/ipv6/Makefile b/net/ipv6/Makefile
> index 3036a45e8a1e..b05b0e4668f5 100644
> --- a/net/ipv6/Makefile
> +++ b/net/ipv6/Makefile
> @@ -47,7 +47,7 @@ obj-y +=3D addrconf_core.o exthdrs_core.o ip6_checksum.=
o ip6_icmp.o
>  obj-$(CONFIG_INET) +=3D output_core.o protocol.o \
>                         ip6_offload.o tcpv6_offload.o exthdrs_offload.o
>
> -obj-$(subst m,y,$(CONFIG_IPV6)) +=3D inet6_hashtables.o
> +obj-$(call always_built_in,$(CONFIG_IPV6)) +=3D inet6_hashtables.o
>
>  ifneq ($(CONFIG_IPV6),)
>  obj-$(CONFIG_NET_UDP_TUNNEL) +=3D ip6_udp_tunnel.o
> diff --git a/net/l2tp/Makefile b/net/l2tp/Makefile
> index cf8f27071d3f..ff94be92a36e 100644
> --- a/net/l2tp/Makefile
> +++ b/net/l2tp/Makefile
> @@ -8,11 +8,11 @@ obj-$(CONFIG_L2TP) +=3D l2tp_core.o
>  CFLAGS_l2tp_core.o +=3D -I$(src)
>
>  # Build l2tp as modules if L2TP is M
> -obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_PPPOL2TP)) +=3D l2tp_ppp.o
> -obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_IP)) +=3D l2tp_ip.o
> -obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_V3)) +=3D l2tp_netlink.o
> -obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_ETH)) +=3D l2tp_eth.o
> -obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_DEBUGFS)) +=3D l2tp_debugfs.o
> +obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_PPPOL2TP)=
)) +=3D l2tp_ppp.o
> +obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_IP))=
) +=3D l2tp_ip.o
> +obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_V3))=
) +=3D l2tp_netlink.o
> +obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_ETH)=
)) +=3D l2tp_eth.o
> +obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_DEBU=
GFS))) +=3D l2tp_debugfs.o
>  ifneq ($(CONFIG_IPV6),)
> -obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_IP)) +=3D l2tp_ip6.o
> +obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_IP))=
) +=3D l2tp_ip6.o
>  endif
> diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
> index 0f060d100880..a6f65c956b1b 100644
> --- a/net/netfilter/Makefile
> +++ b/net/netfilter/Makefile
> @@ -6,7 +6,7 @@ nf_conntrack-y  :=3D nf_conntrack_core.o nf_conntrack_sta=
ndalone.o nf_conntrack_exp
>                    nf_conntrack_proto_icmp.o \
>                    nf_conntrack_extend.o nf_conntrack_acct.o nf_conntrack=
_seqadj.o
>
> -nf_conntrack-$(subst m,y,$(CONFIG_IPV6)) +=3D nf_conntrack_proto_icmpv6.=
o
> +nf_conntrack-$(call always_built_in,$(CONFIG_IPV6)) +=3D nf_conntrack_pr=
oto_icmpv6.o
>  nf_conntrack-$(CONFIG_NF_CONNTRACK_TIMEOUT) +=3D nf_conntrack_timeout.o
>  nf_conntrack-$(CONFIG_NF_CONNTRACK_TIMESTAMP) +=3D nf_conntrack_timestam=
p.o
>  nf_conntrack-$(CONFIG_NF_CONNTRACK_EVENTS) +=3D nf_conntrack_ecache.o
> diff --git a/net/netlabel/Makefile b/net/netlabel/Makefile
> index 5a46381a64e7..8052bd8e7af8 100644
> --- a/net/netlabel/Makefile
> +++ b/net/netlabel/Makefile
> @@ -13,4 +13,4 @@ obj-y +=3D netlabel_mgmt.o
>  # protocol modules
>  obj-y  +=3D netlabel_unlabeled.o
>  obj-y  +=3D netlabel_cipso_v4.o
> -obj-$(subst m,y,$(CONFIG_IPV6)) +=3D netlabel_calipso.o
> +obj-$(call always_built_in,$(CONFIG_IPV6)) +=3D netlabel_calipso.o
> diff --git a/net/sctp/Makefile b/net/sctp/Makefile
> index e845e4588535..683a345f3626 100644
> --- a/net/sctp/Makefile
> +++ b/net/sctp/Makefile
> @@ -21,4 +21,4 @@ sctp-$(CONFIG_SCTP_DBG_OBJCNT) +=3D objcnt.o
>  sctp-$(CONFIG_PROC_FS) +=3D proc.o
>  sctp-$(CONFIG_SYSCTL) +=3D sysctl.o
>
> -sctp-$(subst m,y,$(CONFIG_IPV6))       +=3D ipv6.o
> +sctp-$(call always_built_in,$(CONFIG_IPV6))    +=3D ipv6.o
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 8042c067312e..701bbb499427 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -188,6 +188,21 @@ cmd_and_fixdep =3D                                  =
                           \
>  # and if so will execute $(rule_foo).
>  if_changed_rule =3D $(if $(if-changed-cond),$(rule_$(1)),@:)
>
> +# Usage. $(call always-built-in,CONFIG_VAR)
> +# Expands to y if CONFIG_VAR is m, suitable for always-built-in pieces
> +# of things that otherwise may be modular.
> +always_built_in =3D $(subst M,Y,$(subst m,y,$(1)))
> +
> +# Usage, obj-$(call module_if_any_modular,$(CONCATENATED)$(CONFIG)$(VARS=
))
> +# Expands to m if any of the concatenated config vars are m, otherwise
> +# y if any of them are y, otherwise n
> +module_if_any_modular =3D $(strip \
> +    $(if $(findstring m,$(subst M,m,$(1))), \
> +        $(if $(findstring M,$(1)),M,m), \
> +        $(if $(findstring y,$(subst Y,y,$(1))), \
> +            $(if $(findstring Y,$(1)),Y,y), \
> +            $(if $(findstring N,$(1)),N,n))))
> +
>  ###
>  # why - tell why a target got built
>  #       enabled by make V=3D2
> --
> 2.38.0.266.g481848f278
>


--
Best Regards
Masahiro Yamada
