Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727EE64BF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiLMWqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiLMWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:46:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3522BE4;
        Tue, 13 Dec 2022 14:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+WY48BvUU7u5KUK3bBhgRCrHcWbOntoJRttvP/ac8gk=; b=rpMAE1jBi9d/GA9RIZbBVjWOHX
        ScHq6uQGp57p4wLiK+NxfBimMByafRmQQuyUOzXfnLJDQVyfTHxpaWHj+D85nAlXiujjcoeAyS5xE
        drktELdeR42VQf+8NJMMcXdRARr0cBYVokmnlW0IgwFisjxyj/TV7QXnbOc0yWub3blaMP0H6S+Uu
        vxBiTayZeogxxf1iXcmh8ZJXovkOFlE3EdrSIxDFgdmLfcq37O6jJUy0askzbl8PFtAS27/v9o4d9
        wApIT2i8+CQKW1+fqPGEjYi2Kwy2yTXBT2twArqBgPGWAyiVHX+9MSDJTAyynS4kp4x2axlh2ec5s
        pOr2McPw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5E2R-0081t5-Uu; Tue, 13 Dec 2022 22:46:15 +0000
Date:   Tue, 13 Dec 2022 14:46:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <Y5kAt3WRgncTj26x@bombadil.infradead.org>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
 <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 01:07:53PM -0800, Dan Williams wrote:
> Dan Williams wrote:
> > Luis Chamberlain wrote:
> > > Simply loading cxl_test ends up triggering a null pointer dereference
> > > on next-20221207, 
>
> Ok, my 6.1.0-rc8-next-20221208 build passed.
> 
> # meson test -C build --suite cxl
> ninja: Entering directory `/root/git/ndctl/build'
> [109/109] Linking target ndctl/ndctl
> 1/5 ndctl:cxl / cxl-topology.sh             OK              11.84s
> 2/5 ndctl:cxl / cxl-region-sysfs.sh         OK               6.82s
> 3/5 ndctl:cxl / cxl-labels.sh               OK              10.14s
> 4/5 ndctl:cxl / cxl-create-region.sh        OK              18.32s
> 5/5 ndctl:cxl / security-cxl.sh             OK               3.35s

What branch of ndctl do you use?

> So, what I suspect is happening is

<-- snip -->

Yes you're right.

> From 93bf2c04cd3a708c73c0e4ad7a4121505a0698da Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Fri, 9 Dec 2022 13:04:26 -0800
> Subject: [PATCH] tools/testing/cxl: Prevent cxl_test from confusing production
>  modules
> 
> The cxl_test machinery builds modified versions of the modules in
> drivers/cxl/ and intercepts some of their calls to allow cxl_test to
> inject mock CXL topologies for test.
> 
> However, if cxl_test attempts the same with production modules,
> fireworks ensue as Luis discovered [1]. Prevent that scenario by
> arranging for cxl_test to check for a "watermark" symbol in each of the
> modules it expects to be modified before the test can run. This turns
> undefined runtime behavior or crashes into a safer failure to load the
> cxl_test module.
> 
> Link: http://lore.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org [1]
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Indeed that fixes the same crash. However that highlights a few other
issues.

1) ndcl unit tests still fail once you do get the right driver loaded:
   a) pending branch fails on the first test and stops there
   b) main branch fails at the first test and continues and passes on
   the rest of the tests. What is with the discrepancy?

2) The instructions on ndctl to use an external module are easily
misguiding folks on how to use external replacement modules, I'd like
to suggest a fix below.

Details below.

1a) The tests still fail, worse on ndctl pending branch, it fails on the
first test and just doesn't continue:

vagrant@cxl /data/ndctl (git::pending)$ sudo meson test -C build --suite
cxl
ninja: no work to do.
ninja: Entering directory `/data/ndctl/build'
[1/50] Generating version.h with a custom command
1/1 ndctl:cxl / cxl-topology.sh        FAIL             0.87s   exit
status 1
>>> DATA_PATH=/data/ndctl/test MALLOC_PERTURB_=132
>>> DAXCTL=/data/ndctl/build/daxctl/daxctl
>>> TEST_PATH=/data/ndctl/build/test NDCTL=/data/ndctl/build/ndctl/ndctl
>>> /bin/bash /data/ndctl/test/cxl-topology.sh


Ok:                 0   
Expected Fail:      0   
Fail:               1   
Unexpected Pass:    0   
Skipped:            0   
Timeout:            0   

Full log written to /data/ndctl/build/meson-logs/testlog.txt

The full log:

https://gist.github.com/mcgrof/1237a31821331d503615e136e18ff5f9

1b) Using the main branch, it fails also on topology but continues and
passes the other tests:

vagrant@cxl /data/ndctl (git::main)$ sudo meson test -C build --suite
cxl
ninja: no work to do.
ninja: Entering directory `/data/ndctl/build'
[1/51] Generating version.h with a custom command
1/4 ndctl:cxl / cxl-topology.sh             FAIL             0.96s
exit status 1
>>> TEST_PATH=/data/ndctl/build/test
>>> DAXCTL=/data/ndctl/build/daxctl/daxctl DATA_PATH=/data/ndctl/test
>>> NDCTL=/data/ndctl/build/ndctl/ndctl MALLOC_PERTURB_=123 /bin/bash
>>> /data/ndctl/test/cxl-topology.sh

2/4 ndctl:cxl / cxl-region-sysfs.sh         OK               5.33s
3/4 ndctl:cxl / cxl-labels.sh               OK               3.40s
4/4 ndctl:cxl / cxl-create-region.sh        OK               8.14s

Ok:                 3   
Expected Fail:      0   
Fail:               1   
Unexpected Pass:    0   
Skipped:            0   
Timeout:            0   

Full log written to /data/ndctl/build/meson-logs/testlog.txt

The full log:

https://gist.github.com/mcgrof/b1f7dd67fe44870adbd0c773ac752dcb

The kernel log for the relevant topology failure for both cases
on line 35:

cxl_mem mem0: at cxl_root_port.0 no parent for dport: platform
cxl_mem mem1: at cxl_root_port.1 no parent for dport: platform
cxl_mem mem2: at cxl_root_port.2 no parent for dport: platform
cxl_mem mem3: at cxl_root_port.3 no parent for dport: platform
cxl_mem mem4: at cxl_root_port.0 no parent for dport: platform
cxl_mem mem5: at cxl_root_port.1 no parent for dport: platform
cxl_mem mem6: at cxl_root_port.2 no parent for dport: platform
cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
cxl_mem mem8: at cxl_root_port.4 no parent for dport: platform
cxl_mem mem9: at cxl_root_port.4 no parent for dport: platform
cxl_mem mem10: CXL port topology not found
platform cxl_host_bridge.0: host supports CXL
platform cxl_host_bridge.1: host supports CXL
platform cxl_host_bridge.2: host supports CXL
platform cxl_host_bridge.3: host supports CXL (restricted)

The test in this case is:

# collect cxl_test root device id
json=$($CXL list -b cxl_test)
count=$(jq "length" <<< $json)
((count == 1)) || err "$LINENO"
root=$(jq -r ".[] | .bus" <<< $json)

# validate 2 host bridges under a root port
port_sort="sort_by(.port | .[4:] | tonumber)"
json=$($CXL list -b cxl_test -BP)
count=$(jq ".[] | .[\"ports:$root\"] | length" <<< $json)
((count == 2)) || err "$LINENO"

In my case root is "root0" and this count is 3.

The output of $(cxl list -b cxl_test -BP) is:

[
  {
    "bus":"root0",
    "provider":"cxl_test",
    "ports:root0":[
      {
        "port":"port1",
        "host":"cxl_host_bridge.0",
        "depth":1,
        "ports:port1":[
          {
            "port":"port8",
            "host":"cxl_switch_uport.2",
            "depth":2
          },
          {
            "port":"port4",
            "host":"cxl_switch_uport.0",
            "depth":2
          }
        ]
      },
      {
        "port":"port3",
        "host":"cxl_host_bridge.2",
        "depth":1,
        "ports:port3":[
          {
            "port":"port16",
            "host":"cxl_switch_uport.4",
            "depth":2
          }
        ]
      },
      {
        "port":"port2",
        "host":"cxl_host_bridge.1",
        "depth":1,
        "ports:port2":[
          {
            "port":"port6",
            "host":"cxl_switch_uport.1",
            "depth":2
          },
          {
            "port":"port10",
            "host":"cxl_switch_uport.3",
            "depth":2
          }
        ]
      }
    ]
  }
]

Anyway I think we should simplify the ndctl README.md to just use
INSTALL_MOD_DIR follows, thoughts?

But this also raises the question of *if* using ndctl and linux-next
shoudl one use the main branch or the pending branch? Can there be
issues with synchronizing ? Or should the main branch always work,
and the pending should just have the latest and greatest and *can*
fail?

If we wanted to automate nightly tests what should we use?

From c97b0de23fa8b9cc8945e20cea134a61868ada40 Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 13 Dec 2022 22:34:35 +0000
Subject: [PATCH] README.md: recommend to use INSTALL_MOD_DIR

By default depmod will only look at the updates directory for modules,
and so if one wants to replace production modules with alternatives
one can just use INSTALL_MOD_DIR=updates at modules_install time.

This will ensure that the correctly mocked modules are used, whether
that is for cxl or libnvdimm.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 README.md | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index e5c4940..fd285af 100644
--- a/README.md
+++ b/README.md
@@ -74,16 +74,17 @@ loaded.  To build and install nfit_test.ko:
    CONFIG_ENCRYPTED_KEYS=y
    ```
 
-1. Build and install the unit test enabled libnvdimm modules in the
-   following order.  The unit test modules need to be in place prior to
-   the `depmod` that runs during the final `modules_install`  
+1. Build and install the unit test enabled libnvdimm modules
 
    ```
-   make M=tools/testing/nvdimm
-   sudo make M=tools/testing/nvdimm modules_install
    sudo make modules_install
+   make M=tools/testing/nvdimm
+   sudo make M=tools/testing/nvdimm modules_install INSTALL_MOD_DIR=updates
    ```
 
+To uninstall and use the production nvdimm modules just rm -rf the updates
+directory from the respective kernel /lib/modules/ directory and run depmod -a.
+
 1. Now run `meson test -C build` in the ndctl source directory, or `ndctl test`,
    if ndctl was built with `-Dtest=enabled` as a configuration option to meson.
 
-- 
2.35.1

