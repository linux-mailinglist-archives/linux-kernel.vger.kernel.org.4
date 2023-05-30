Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47183715AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjE3KBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjE3KBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:01:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E89C;
        Tue, 30 May 2023 03:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA8962CE5;
        Tue, 30 May 2023 10:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3958C433EF;
        Tue, 30 May 2023 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685440865;
        bh=jl17F4MOLv0zENAC30BsKiw6pJa3U0ooVb+mA87wg0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxdN1L5OznmTi/YBzeyTxLZIz9dsDYc4uzWt9rpxelEjhC3PrXcqUFl5YWlquRSXk
         tMxd7ic6I22ynfIxzZqJjncl9w8D1BNGDw3/H50CkqQnwyyrsIBH11VpWdwhhn87p6
         iex12VNZ9fW25Iab3p6JnE4FMcT/64YrL9mZyd/3DucfbN8OeB9MUt+0YbFd/i9ZVZ
         jE1U2yN9lawujIOmG5t0VMVsHPtMQN/mYjBXCa7O/7H0o0q+571f4PN38caU8yp1CJ
         o6ay+DtH1tCvR7G0HXI1pt9b92+VmDuHhdBIiItuwDsskjqeC8dJgp1Msg89+xl+wg
         ICD7fNxz6PLdg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q3wA4-00007m-SI; Tue, 30 May 2023 12:01:05 +0200
Date:   Tue, 30 May 2023 12:01:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZHXJYONMLOLK_Mkd@hovoldconsulting.com>
References: <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
 <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <CAHk-=whHRAntqwt_iGAdezj4i33GTmN+Oa8z3CNz4LO0Puo85g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whHRAntqwt_iGAdezj4i33GTmN+Oa8z3CNz4LO0Puo85g@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 01:47:28PM -0400, Linus Torvalds wrote:
> On Mon, May 29, 2023 at 8:44 AM Johan Hovold <johan@kernel.org> wrote:

> > > I do wonder what it is that is different in your setup, and maybe you
> > > could also enable the
> > >
> > >         pr_debug("finit_module: fd=%d, uargs=%p, flags=%i\n", fd, uargs, flags);
> >
> > Below is the corresponding output with a working kernel: 174 requests
> > for the 131 modules that end up being loaded (without the revert there
> > is only around 110 modules loaded).

> And yeah, that dmesg output is useless, I didn't think of the fact
> that it only prints out the file descriptor, not the actual path to
> the file. In fact, without that change in place, the module code never
> actually looks at the file and leaves it all to
> kernel_read_file_from_fd().

Yeah, I added a printk with the module name to load_module() to make
some sense of it.
 
> With my change, it woul dhave been trivial to use "%pD" and point it
> at the file pointer instead, and get the dentry name that way, but
> never mind.  I think you're entirely right that it's probably due to a
> shared dependency module, and I just didn't happen to trigger that
> case.

For completeness, here's a corresponding log from when running with your
RFC. Those duplicate requests that now wait for loading to complete
would have failed, and that explains why some modules like
qcom-spmi-adc5 and qcom-spmi-adc-tm5 that both depend on
qcom-vadc-common would in turn fail to load.

Johan

[    0.633127] init_module_from_file - i2c-core.ko
[    0.638320] init_module_from_file - i2c-hid.ko
[    0.640654] init_module_from_file - i2c-hid-of.ko
[    0.642572] init_module_from_file - i2c-qcom-geni.ko
[    0.826911] init_module_from_file - hid-multitouch.ko
[    0.827861] init_module_from_file - nvme-core.ko
[    0.833011] init_module_from_file - nvme.ko
[    0.835558] init_module_from_file - phy-qcom-qmp-pcie.ko
[    0.841050] init_module_from_file - crc8.ko
[    0.841371] init_module_from_file - pcie-qcom.ko
[    3.390182] init_module_from_file - ipv6.ko
[    3.402261] init_module_from_file - x_tables.ko
[    3.406573] init_module_from_file - ip_tables.ko
[    4.180345] init_module_from_file - dm-mod.ko
[    4.186611] init_module_from_file - drm.ko
[    4.793481] init_module_from_file - pwm_bl.ko
[    4.798935] init_module_from_file - soundwire-bus.ko
[    4.802551] init_module_from_file - qmi_helpers.ko
[    4.805664] init_module_from_file - socinfo.ko
[    4.814729] init_module_from_file - pdr_interface.ko
[    4.830809] init_module_from_file - soundcore.ko
[    4.832227] init_module_from_file - qcom-wdt.ko
[    4.832242] init_module_from_file - qcom-rng.ko
[    4.832311] init_module_from_file - icc-osm-l3.ko
[    4.867903] init_module_from_file - pmic_glink.ko
[    4.867904] init_module_from_file - snd.ko
[    4.868045] init_module_from_file - mdt_loader.ko
[    4.890274] init_module_from_file - snd.ko
[    4.893962] init_module_from_file - snd.ko
[    4.894620] init_module_from_file - snd.ko
[    4.896162] init_module_from_file - snd.ko
[    4.896797] init_module_from_file - snd.ko
[    4.896907] init_module_from_file - snd.ko
[    4.898087] init_module_from_file - snd.ko
[    4.907548] init_module_from_file - qcom_sysmon.ko
[    4.907560] init_module_from_file - qcom_sysmon.ko
[    4.918690] init_module_from_file - snd.ko - waited, ret = 0
[    4.918692] init_module_from_file - snd.ko - waited, ret = 0
[    4.918694] init_module_from_file - snd.ko - waited, ret = 0
[    4.918695] init_module_from_file - snd.ko - waited, ret = 0
[    4.918699] init_module_from_file - snd.ko - waited, ret = 0
[    4.918700] init_module_from_file - snd.ko - waited, ret = 0
[    4.920849] init_module_from_file - snd.ko - waited, ret = 0
[    4.937139] init_module_from_file - qrtr.ko
[    4.937163] init_module_from_file - icc-bwmon.ko
[    4.937185] init_module_from_file - icc-bwmon.ko
[    4.938603] init_module_from_file - qcom_sysmon.ko - waited, ret = 0
[    4.939866] init_module_from_file - snd-timer.ko
[    4.939877] init_module_from_file - snd-timer.ko
[    4.939885] init_module_from_file - snd-timer.ko
[    4.939897] init_module_from_file - snd-timer.ko
[    4.939905] init_module_from_file - snd-timer.ko
[    4.939914] init_module_from_file - snd-timer.ko
[    4.939982] init_module_from_file - snd-timer.ko
[    4.940050] init_module_from_file - snd-timer.ko
[    4.943465] init_module_from_file - pinctrl-lpass-lpi.ko
[    4.943493] init_module_from_file - phy-qcom-snps-femto-v2.ko
[    4.943512] init_module_from_file - phy-qcom-snps-femto-v2.ko
[    4.944176] init_module_from_file - qcom_q6v5.ko
[    4.944362] init_module_from_file - qcom_q6v5.ko
[    4.946140] init_module_from_file - qcom_q6v5.ko - waited, ret = 0
[    4.946758] init_module_from_file - snd-timer.ko - waited, ret = 0
[    4.946762] init_module_from_file - snd-timer.ko - waited, ret = 0
[    4.946919] init_module_from_file - snd-timer.ko - waited, ret = 0
[    4.947484] init_module_from_file - snd-timer.ko - waited, ret = 0
[    4.947827] init_module_from_file - snd-timer.ko - waited, ret = 0
[    4.948101] init_module_from_file - snd-timer.ko - waited, ret = 0
[    4.948163] init_module_from_file - snd-timer.ko - waited, ret = 0
[    4.948483] init_module_from_file - phy-qcom-snps-femto-v2.ko - waited, ret = 0
[    4.950639] init_module_from_file - icc-bwmon.ko - waited, ret = 0
[    4.951178] init_module_from_file - snd-pcm.ko
[    4.951279] init_module_from_file - snd-pcm.ko
[    4.951616] init_module_from_file - qcom_glink_smem.ko
[    4.952049] init_module_from_file - snd-pcm.ko
[    4.952122] init_module_from_file - snd-pcm.ko
[    4.952132] init_module_from_file - snd-pcm.ko
[    4.952185] init_module_from_file - snd-pcm.ko
[    4.952231] init_module_from_file - pinctrl-sc8280xp-lpass-lpi.ko
[    4.952238] init_module_from_file - snd-pcm.ko
[    4.952326] init_module_from_file - qcom_glink_smem.ko
[    4.957870] init_module_from_file - snd-pcm.ko
[    4.971513] init_module_from_file - typec.ko
[    4.971529] init_module_from_file - typec.ko
[    4.971544] init_module_from_file - phy-qcom-edp.ko
[    4.971619] init_module_from_file - typec.ko
[    4.971806] init_module_from_file - snd-pcm.ko
[    4.971961] init_module_from_file - qcom_common.ko
[    4.972583] init_module_from_file - qcom_common.ko
[    4.972676] init_module_from_file - rfkill.ko
[    4.972898] init_module_from_file - qcom_stats.ko
[    4.973031] init_module_from_file - typec.ko
[    4.973917] init_module_from_file - snd-pcm.ko - waited, ret = 0
[    4.974024] init_module_from_file - snd-pcm.ko - waited, ret = 0
[    4.974090] init_module_from_file - qcom_common.ko - waited, ret = 0
[    4.974134] init_module_from_file - snd-pcm.ko - waited, ret = 0
[    4.974205] init_module_from_file - snd-pcm.ko - waited, ret = 0
[    4.974265] init_module_from_file - snd-pcm.ko - waited, ret = 0
[    4.974307] init_module_from_file - snd-pcm.ko - waited, ret = 0
[    4.974385] init_module_from_file - snd-pcm.ko - waited, ret = 0
[    4.974436] init_module_from_file - snd-pcm.ko - waited, ret = 0
[    4.979168] init_module_from_file - qcom_pil_info.ko
[    4.979352] init_module_from_file - snd-compress.ko
[    4.979399] init_module_from_file - qcom_pil_info.ko
[    4.979668] init_module_from_file - snd-compress.ko
[    4.979912] init_module_from_file - snd-compress.ko
[    4.980022] init_module_from_file - rtc-pm8xxx.ko
[    4.980107] init_module_from_file - snd-compress.ko
[    4.980216] init_module_from_file - sysimgblt.ko
[    4.980490] init_module_from_file - nvmem_qcom-spmi-sdam.ko
[    4.980593] init_module_from_file - snd-compress.ko
[    4.981109] init_module_from_file - snd-compress.ko
[    4.981136] init_module_from_file - qcom_pil_info.ko - waited, ret = 0
[    4.981285] init_module_from_file - snd-compress.ko
[    4.981378] init_module_from_file - typec.ko - waited, ret = 0
[    4.981382] init_module_from_file - typec.ko - waited, ret = 0
[    4.981402] init_module_from_file - snd-compress.ko - waited, ret = 0
[    4.981404] init_module_from_file - snd-compress.ko - waited, ret = 0
[    4.981412] init_module_from_file - typec.ko - waited, ret = 0
[    4.981453] init_module_from_file - snd-compress.ko - waited, ret = 0
[    4.981482] init_module_from_file - snd-compress.ko - waited, ret = 0
[    4.981516] init_module_from_file - snd-compress.ko - waited, ret = 0
[    4.981620] init_module_from_file - snd-compress.ko
[    4.982970] init_module_from_file - snd-compress.ko
[    4.985063] init_module_from_file - qcom_q6v5_pas.ko
[    4.985132] init_module_from_file - qcom_q6v5_pas.ko
[    4.985200] init_module_from_file - snd-soc-core.ko
[    4.985222] init_module_from_file - qcom-vadc-common.ko
[    4.985254] init_module_from_file - sysfillrect.ko
[    4.985654] init_module_from_file - snd-soc-core.ko
[    4.985697] init_module_from_file - sysfillrect.ko
[    4.985862] init_module_from_file - snd-soc-core.ko
[    4.985883] init_module_from_file - ecc.ko
[    4.985950] init_module_from_file - reboot-mode.ko
[    4.985982] init_module_from_file - snd-soc-core.ko
[    4.986159] init_module_from_file - snd-soc-core.ko
[    4.986304] init_module_from_file - snd-soc-core.ko
[    4.986829] init_module_from_file - qcom-vadc-common.ko
[    4.987106] init_module_from_file - snd-soc-core.ko
[    4.987546] init_module_from_file - qcom-vadc-common.ko - waited, ret = 0
[    4.987889] init_module_from_file - snd-soc-core.ko
[    4.988198] init_module_from_file - snd-soc-core.ko
[    4.989151] init_module_from_file - industrialio.ko
[    4.989220] init_module_from_file - industrialio.ko
[    4.989588] init_module_from_file - gpio-sbu-mux.ko
[    4.989651] init_module_from_file - gpio-sbu-mux.ko
[    4.990037] init_module_from_file - qcom-pon.ko
[    4.991354] init_module_from_file - mhi.ko
[    4.992889] init_module_from_file - industrialio.ko - waited, ret = 0
[    4.993473] init_module_from_file - cfg80211.ko
[    4.994053] init_module_from_file - snd-soc-core.ko - waited, ret = 0
[    4.994073] init_module_from_file - snd-soc-core.ko - waited, ret = 0
[    4.994103] init_module_from_file - snd-soc-core.ko - waited, ret = 0
[    4.994107] init_module_from_file - snd-soc-core.ko - waited, ret = 0
[    4.994129] init_module_from_file - snd-soc-core.ko - waited, ret = 0
[    4.994147] init_module_from_file - snd-soc-core.ko - waited, ret = 0
[    4.994166] init_module_from_file - sysfillrect.ko
[    4.994176] init_module_from_file - snd-soc-core.ko - waited, ret = 0
[    4.994206] init_module_from_file - snd-soc-core.ko - waited, ret = 0
[    4.994319] init_module_from_file - qcom-spmi-adc5.ko
[    4.994621] init_module_from_file - ecdh_generic.ko
[    4.994975] init_module_from_file - snd-soc-lpass-macro-common.ko
[    4.994999] init_module_from_file - qcom-spmi-adc-tm5.ko
[    4.996797] init_module_from_file - gpio-sbu-mux.ko - waited, ret = 0
[    4.997487] init_module_from_file - snd-soc-qcom-sdw.ko
[    4.997511] init_module_from_file - snd-soc-lpass-macro-common.ko
[    4.997546] init_module_from_file - snd-soc-wcd-mbhc.ko
[    4.997573] init_module_from_file - sysfillrect.ko - waited, ret = 0
[    4.997754] init_module_from_file - syscopyarea.ko
[    4.997762] init_module_from_file - syscopyarea.ko
[    4.999053] init_module_from_file - sysfillrect.ko - waited, ret = 0
[    4.999247] init_module_from_file - snd-soc-lpass-macro-common.ko
[    4.999482] init_module_from_file - snd-soc-lpass-wsa-macro.ko
[    4.999587] init_module_from_file - soundwire-qcom.ko
[    5.000338] init_module_from_file - soundwire-qcom.ko
[    5.000745] init_module_from_file - soundwire-qcom.ko
[    5.001008] init_module_from_file - syscopyarea.ko
[    5.015734] init_module_from_file - bluetooth.ko
[    5.016020] init_module_from_file - regmap-sdw.ko
[    5.016434] init_module_from_file - snd-soc-qcom-common.ko
[    5.017416] init_module_from_file - syscopyarea.ko - waited, ret = 0
[    5.018912] init_module_from_file - snd-soc-lpass-macro-common.ko - waited, ret = 0
[    5.018952] init_module_from_file - syscopyarea.ko - waited, ret = 0
[    5.019196] init_module_from_file - snd-soc-lpass-macro-common.ko - waited, ret = 0
[    5.020220] init_module_from_file - drm_kms_helper.ko
[    5.020230] init_module_from_file - snd-soc-lpass-rx-macro.ko
[    5.023262] init_module_from_file - drm_kms_helper.ko
[    5.023366] init_module_from_file - snd-soc-wcd938x-sdw.ko
[    5.023705] init_module_from_file - snd-soc-lpass-va-macro.ko
[    5.024133] init_module_from_file - drm_kms_helper.ko
[    5.024223] init_module_from_file - snd-soc-sc8280xp.ko
[    5.024814] init_module_from_file - snd-soc-lpass-tx-macro.ko
[    5.027886] init_module_from_file - drm_kms_helper.ko - waited, ret = 0
[    5.027937] init_module_from_file - drm_kms_helper.ko - waited, ret = 0
[    5.028550] init_module_from_file - phy-qcom-qmp-combo.ko
[    5.028828] init_module_from_file - snd-soc-wcd938x.ko
[    5.029106] init_module_from_file - drm_dp_aux_bus.ko
[    5.030265] init_module_from_file - phy-qcom-qmp-combo.ko
[    5.037773] init_module_from_file - qcom_q6v5_pas.ko - waited, ret = 0
[    5.038034] init_module_from_file - soundwire-qcom.ko - waited, ret = 0
[    5.038548] init_module_from_file - libarc4.ko
[    5.038551] init_module_from_file - soundwire-qcom.ko - waited, ret = 0
[    5.042176] init_module_from_file - btqca.ko
[    5.044433] init_module_from_file - mac80211.ko
[    5.044480] init_module_from_file - drm_display_helper.ko
[    5.046672] init_module_from_file - qcom-spmi-temp-alarm.ko
[    5.048163] init_module_from_file - hci_uart.ko
[    5.056843] init_module_from_file - gpu-sched.ko
[    5.073356] init_module_from_file - led-class-multicolor.ko
[    5.087906] init_module_from_file - qcom-spmi-temp-alarm.ko
[    5.106010] init_module_from_file - ath11k.ko
[    5.106084] init_module_from_file - msm.ko
[    5.125345] init_module_from_file - leds-qcom-lpg.ko
[    5.150715] init_module_from_file - ath11k_pci.ko
[    5.157163] init_module_from_file - qcom-spmi-temp-alarm.ko - waited, ret = 0
[    5.157894] init_module_from_file - qcom_battmgr.ko
[    5.158102] init_module_from_file - phy-qcom-qmp-combo.ko - waited, ret = 0
[    5.159204] init_module_from_file - pmic_glink_altmode.ko
[    5.258217] init_module_from_file - qrtr-smd.ko
[    5.258238] init_module_from_file - qrtr-smd.ko
[    5.258294] init_module_from_file - rpmsg_char.ko
[    5.259157] init_module_from_file - apr.ko
[    5.259160] init_module_from_file - rpmsg_char.ko
[    5.276634] init_module_from_file - qrtr-smd.ko - waited, ret = 0
[    5.277698] init_module_from_file - fastrpc.ko
[    5.278293] init_module_from_file - rpmsg_char.ko - waited, ret = 0
[    5.278926] init_module_from_file - rpmsg_ctrl.ko
[    5.279642] init_module_from_file - rpmsg_ctrl.ko
[    5.281399] init_module_from_file - rpmsg_ctrl.ko - waited, ret = 0
[    5.330747] init_module_from_file - snd-soc-hdmi-codec.ko
[    5.330826] init_module_from_file - snd-soc-hdmi-codec.ko
[    5.333130] init_module_from_file - snd-soc-hdmi-codec.ko
[    5.333201] init_module_from_file - snd-soc-hdmi-codec.ko - waited, ret = 0
[    5.333214] init_module_from_file - snd-soc-hdmi-codec.ko - waited, ret = 0
[    5.396803] init_module_from_file - panel-edp.ko
[    6.101509] init_module_from_file - qrtr-mhi.ko
[    6.196359] init_module_from_file - iptable_filter.ko
[    6.203333] init_module_from_file - nf_defrag_ipv4.ko
[    6.203903] init_module_from_file - nf_defrag_ipv6.ko
[    6.204628] init_module_from_file - libcrc32c.ko
[    6.204727] init_module_from_file - snd-q6apm.ko
[    6.204985] init_module_from_file - snd-q6apm.ko
[    6.205007] init_module_from_file - nf_conntrack.ko
[    6.207137] init_module_from_file - xt_conntrack.ko
[    6.211214] init_module_from_file - xt_tcpudp.ko
[    6.215535] init_module_from_file - nf_reject_ipv4.ko
[    6.216071] init_module_from_file - ipt_REJECT.ko
[    6.222201] init_module_from_file - nf_log_syslog.ko
[    6.223050] init_module_from_file - xt_LOG.ko
[    6.241544] init_module_from_file - ip6_tables.ko
[    6.286511] init_module_from_file - af_alg.ko
[    6.293272] init_module_from_file - algif_hash.ko
[    6.304773] init_module_from_file - md5.ko
[    6.333540] init_module_from_file - mii.ko
[    6.333550] init_module_from_file - mii.ko
[    6.334785] init_module_from_file - mii.ko - waited, ret = 0
[    6.335170] init_module_from_file - r8152.ko
[    6.335282] init_module_from_file - r8152.ko
[    6.370285] init_module_from_file - algif_skcipher.ko
[    6.384424] init_module_from_file - ecb.ko
[    6.392643] init_module_from_file - libdes.ko
[    6.397046] init_module_from_file - des_generic.ko
[    6.416039] init_module_from_file - cbc.ko
[    6.643702] init_module_from_file - r8152.ko - waited, ret = 0
[    7.940666] init_module_from_file - michael_mic.ko
[   11.233648] init_module_from_file - snd-q6apm.ko - waited, ret = 0
[   11.234264] init_module_from_file - q6prm.ko
[   11.303802] init_module_from_file - q6apm-dai.ko
[   11.304498] init_module_from_file - snd-q6dsp-common.ko
[   11.305476] init_module_from_file - q6apm-lpass-dais.ko
[   11.309858] init_module_from_file - q6prm-clocks.ko
[   11.446919] init_module_from_file - snd-soc-wsa883x.ko
[   11.446953] init_module_from_file - snd-soc-wsa883x.ko
[   11.456469] init_module_from_file - snd-soc-wsa883x.ko - waited, ret = 0
