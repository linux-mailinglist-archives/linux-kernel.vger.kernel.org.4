Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E896A6148
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjB1Vdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Vd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:33:29 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCF71CF7A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:33:27 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9E5113002727B;
        Tue, 28 Feb 2023 22:33:25 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 94FB03703C; Tue, 28 Feb 2023 22:33:25 +0100 (CET)
Date:   Tue, 28 Feb 2023 22:33:25 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast from
 restricted pci_channel_state_t
Message-ID: <20230228213325.GA21769@wunner.de>
References: <202303010454.jI5Jg2sT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303010454.jI5Jg2sT-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

0-day is reporting sparse warnings introduced by commit 74ff8864cc84
("PCI: hotplug: Allow marking devices as disconnected during
bind/unbind"), which landed in Linus' tree this week.

The warnings are caused by invocations of xchg() and cmpxchg()
on an enum type ("cast from restricted pci_channel_state_t").

It seems they are only reported for architectures whose arch_xchg()
and arch_cmpxchg() macros cast the argument to an unsigned long.
Archictures such as x86 don't do that, but a number of others do.
The 0-day report, reproduced below in full, is for loongarch.

I'm wondering why the cast is necessary at all.  Digging in the
git history, I noticed that it has existed at least on arm since
forever.  I suspect that its use on newer arches such as loongarch
may be due to cargo-culting.

Please advise whether these sparse warnings are false positives which
can be ignored and if they aren't, how to resolve them.  If you happen
to know the rationale for the cast, I'd be grateful if you could shed
some light on it.  Thanks a lot!


On Wed, Mar 01, 2023 at 04:39:24AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e492250d5252635b6c97d52eddf2792ec26f1ec1
> commit: 74ff8864cc842be994853095dba6db48e716400a PCI: hotplug: Allow marking devices as disconnected during bind/unbind
> date:   13 days ago
> config: loongarch-randconfig-s042-20230226 (https://download.01.org/0day-ci/archive/20230301/202303010454.jI5Jg2sT-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74ff8864cc842be994853095dba6db48e716400a
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 74ff8864cc842be994853095dba6db48e716400a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303010454.jI5Jg2sT-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/pci/pcie/err.c: note: in included file:
> >> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast from restricted pci_channel_state_t
> >> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast to restricted pci_channel_state_t
>    drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast from restricted pci_channel_state_t
>    drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast from restricted pci_channel_state_t
>    drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast to restricted pci_channel_state_t
>    drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast from restricted pci_channel_state_t
>    drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast from restricted pci_channel_state_t
>    drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast to restricted pci_channel_state_t
> >> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast to restricted pci_channel_state_t
>    drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast to restricted pci_channel_state_t
>    drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast to restricted pci_channel_state_t
> 
> vim +325 drivers/pci/pcie/../pci.h
> 
>    306	
>    307	/**
>    308	 * pci_dev_set_io_state - Set the new error state if possible.
>    309	 *
>    310	 * @dev: PCI device to set new error_state
>    311	 * @new: the state we want dev to be in
>    312	 *
>    313	 * If the device is experiencing perm_failure, it has to remain in that state.
>    314	 * Any other transition is allowed.
>    315	 *
>    316	 * Returns true if state has been changed to the requested state.
>    317	 */
>    318	static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>    319						pci_channel_state_t new)
>    320	{
>    321		pci_channel_state_t old;
>    322	
>    323		switch (new) {
>    324		case pci_channel_io_perm_failure:
>  > 325			xchg(&dev->error_state, pci_channel_io_perm_failure);
>    326			return true;
>    327		case pci_channel_io_frozen:
>    328			old = cmpxchg(&dev->error_state, pci_channel_io_normal,
>    329				      pci_channel_io_frozen);
>    330			return old != pci_channel_io_perm_failure;
>    331		case pci_channel_io_normal:
>    332			old = cmpxchg(&dev->error_state, pci_channel_io_frozen,
>    333				      pci_channel_io_normal);
>    334			return old != pci_channel_io_perm_failure;
>    335		default:
>    336			return false;
>    337		}
>    338	}
>    339	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
